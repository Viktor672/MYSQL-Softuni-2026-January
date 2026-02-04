-- Using Database soft_uni

-- 01
delimiter //
create function ufn_count_employees_by_town(town_name varchar(30))
returns int
deterministic
begin
return (
select count(*) from employees as e
join addresses as a
on e.address_id = a.address_id
join towns as t
on a.town_id = t.town_id
where t.name = town_name);
end//
delimiter ;

select ufn_count_employees_by_town('Sofia') as count;

-- 02
delimiter //
create procedure usp_raise_salaries(in department_name varchar(50))
begin
update employees as e
join departments as d
on e.department_id = d.department_id
set e.salary = e.salary * 1.05
where d.`name` = department_name;
end//
delimiter ;

call usp_raise_salaries('Sales');

-- 03
delimiter //
create procedure usp_raise_salary_by_id(in id int)
begin
start transaction;
if( ( select employee_id from employees where employee_id = id) is not null)
then update employees
set salary = salary * 1.05;
else rollback;
end if;
end//
delimiter ;

-- 04
create table deleted_employees (
employee_id int primary key auto_increment,
first_name varchar(30),
last_name varchar(30),
middle_name varchar(30),
job_title varchar(50),
department_id int,
salary decimal(10, 2)
);

delimiter //
create trigger tr_after_delete_employee
after delete on employees
for each row
begin
insert into deleted_employees(
first_name,
last_name, 
middle_name, 
job_title, 
department_id, 
salary
) 
values
(old.first_name,
old.last_name,
old.middle_name,
old.job_title,
old.department_id,
old.salary);
end//
delimiter ;