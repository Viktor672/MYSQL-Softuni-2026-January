-- Using Database soft_uni
-- 01
delimiter //
create procedure usp_get_employees_salary_above_35000 ()
begin
select first_name, last_name from employees
where salary > 35000
order by first_name asc, last_name asc, employee_id asc;
end//
delimiter ;

-- 02
delimiter //
create procedure usp_get_employees_salary_above (salary_to_compare decimal(20,4))
begin
select first_name, last_name from employees
where salary >= salary_to_compare
order by first_name asc, last_name asc, employee_id asc;
end//
delimiter ;

-- 03
delimiter //
create procedure usp_get_towns_starting_with (starting_string varchar(50))
begin
select `name` from towns
where lower(`name`) like concat(lower(starting_string), '%')
order by `name` asc;
end//
delimiter ;

-- 04
delimiter //
create procedure usp_get_employees_from_town (town_name varchar(30))
begin
select e.first_name, e.last_name from employees as e
join addresses as a
on e.address_id = a.address_id
join towns as t
on a.town_id = t.town_id
where t.name = town_name
order by first_name asc, last_name asc, e.employee_id asc;
end//
delimiter ;

-- 05
delimiter //
create function ufn_get_salary_level (employee_salary decimal(20,2))
returns varchar(30)
deterministic
begin
if (employee_salary < 30000) then return 'Low';
elseif (employee_salary between 30000 and 50000) then return 'Average';
elseif (employee_salary > 50000) then return 'High';
end if;
end//
delimiter ;

-- 06
delimiter //
create procedure usp_get_employees_by_salary_level (salary_level varchar(20))
begin
select first_name, last_name from employees
where ufn_get_salary_level(salary) = salary_level
order by first_name desc, last_name desc;
end//
delimiter ;

-- 07
delimiter //
create function ufn_is_word_comprised (set_of_letters varchar(50), word varchar(50))
returns int
deterministic
begin
declare isCompromised boolean;
set isCompromised = word regexp concat('^[', set_of_letters, ']+$');

return ( select isCompromised as result );
end//
delimiter ;

-- 08
delimiter //
create procedure usp_get_holders_full_name ()
begin
select concat_ws(' ', first_name, last_name) as full_name from account_holders
order by full_name asc, id asc;
end//
delimiter ;

-- 09
delimiter //
create procedure usp_get_holders_with_balance_higher_than (supplied_number int)
begin
select first_name, last_name as balance from account_holders as ah
join accounts as a
on ah.id = a.account_holder_id
group by a.account_holder_id
having sum(a.balance) > supplied_number
order by ah.id asc;
end//
delimiter ;

-- 10
delimiter //
create function ufn_calculate_future_value (sum decimal(20, 4), yearly_interest_rate double, number_of_years int)
returns decimal(20, 4)
deterministic
begin
return sum * ( pow( ( 1 + yearly_interest_rate ), number_of_years ) );
end//
delimiter ;

-- 11
delimiter //
create procedure usp_calculate_future_value_for_account (account_id int, interest_rate decimal(20, 4))
begin
select account_id, ah.first_name, ah.last_name,
a.balance as current_balance,
round(ufn_calculate_future_value(a.balance, interest_rate, 5), 4) as balance_in_5_years from account_holders as ah
join accounts as a
on ah.id = a.account_holder_id
where a.id = account_id;
end//
delimiter ;

-- 12
delimiter //
create procedure usp_deposit_money (account_id int, money_amount decimal(20, 4))
begin
start transaction;
if (money_amount > 0) then
update accounts
set balance = balance + money_amount
where id = account_id;
commit;
else rollback;
end if;
end//
delimiter ;

-- 13
delimiter //
create procedure usp_withdraw_money (account_id int, money_amount decimal(20, 4))
begin
start transaction;
if ( (select balance from accounts where id = account_id) < money_amount or money_amount <= 0) then rollback;
else
update accounts
set balance = balance - money_amount
where id = account_id;
commit;
end if;
end//
delimiter ;

-- 14
delimiter //
create procedure usp_transfer_money (from_account_id int, to_account_id int, amount decimal(20, 4))
begin
declare is_from_account_id_valid boolean;
declare is_to_account_id_valid boolean;
declare is_amount_positive boolean;
declare is_from_account_balance_enough boolean;
declare are_both_accounts_different boolean;

start transaction;

set is_from_account_id_valid = if( ( select id from accounts where id = from_account_id ) is not null, 1, 0);
set is_to_account_id_valid = if( ( select id from accounts where id = to_account_id ) is not null, 1, 0);
set is_amount_positive = if(amount > 0, 1, 0);
set is_from_account_balance_enough = if( ( select balance from accounts where id = from_account_id ) >= amount, 1, 0);
set are_both_accounts_different = if(from_account_id != to_account_id, 1, 0);

if (!is_from_account_id_valid or
!is_to_account_id_valid or
!is_amount_positive or
!is_from_account_balance_enough or
!are_both_accounts_different) then rollback;
else
update accounts
set balance = round(balance - amount, 4)
where id = from_account_id;

update accounts
set balance = round(balance + amount, 4)
where id = to_account_id;
commit;
end if;
end//
delimiter ;

-- 15
create table logs (
log_id int primary key auto_increment,
account_id int,
old_sum decimal(20, 4),
new_sum decimal(20, 4)
);

delimiter //
create trigger tr_after_balance_changed
after update on accounts
for each row
begin
if (old.balance != new.balance) then
insert into logs (account_id, old_sum, new_sum)
values
(old.id, old.balance, new.balance);
end if;
end//
delimiter ;

-- 16
create table notification_emails (
id int primary key auto_increment,
recipient int,
`subject` text,
body text
);

delimiter //
create trigger tr_after_record_added
after insert on logs
for each row
begin
declare current_date_time varchar(100);

SET current_date_time = DATE_FORMAT(NOW(), '%b %e %Y at %r');

insert into notification_emails (recipient, `subject`, body)
values
(new.account_id, concat('Balance change for account: ', new.account_id),
concat('On ', current_date_time, ' your balance was changed from ', new.old_sum, ' to ', new.new_sum, '.') );
end//
delimiter ;
