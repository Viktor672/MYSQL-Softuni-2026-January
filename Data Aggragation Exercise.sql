SET SQL_SAFE_UPDATES = 0;

-- Using Database gringotts
-- 01
select count(*) from wizzard_deposits;

-- 02
select magic_wand_size
from wizzard_deposits
order by magic_wand_size desc
limit 1;

-- 03
select deposit_group, max(magic_wand_size) as longest_magic_wand from wizzard_deposits
group by deposit_group
order by longest_magic_wand asc, deposit_group asc;

-- 04
select deposit_group from wizzard_deposits
group by deposit_group
order by avg(magic_wand_size) asc
limit 1;

-- 05
select deposit_group, sum(deposit_amount) as total_sum from wizzard_deposits
group by deposit_group
order by total_sum asc;

-- 06
select deposit_group, sum(deposit_amount) as total_sum from wizzard_deposits
where magic_wand_creator = 'Ollivander family'
group by deposit_group
order by deposit_group asc;

-- 07
select deposit_group, sum(deposit_amount) as total_sum from wizzard_deposits
where magic_wand_creator = 'Ollivander family'
group by deposit_group
having total_sum < 150000
order by total_sum desc;

-- 08
select deposit_group, magic_wand_creator, min(deposit_charge) as min_deposit_charge from wizzard_deposits
group by deposit_group, magic_wand_creator
order by magic_wand_creator asc, deposit_group asc;

-- 09
select 
case
when age >= 0 and age <=10 then '[0-10]'
when age >= 11 and age <= 20 then '[11-20]'
when age>=21 and age<=30 then '[21-30]'
when age>=31 and age<=40 then '[31-40]'
when age>=41 and age<=50 then '[41-50]'
when age>=51 and age<=60 then '[51-60]'
when age>60 then '[61+]'
end as age_group,
count(*) as wizzard_count
from wizzard_deposits
group by age_group
order by age_group;

-- 10
select distinct(substring(first_name, 1, 1)) as first_letter from wizzard_deposits
where deposit_group = 'Troll Chest'
order by first_letter asc;

-- 11
select deposit_group, is_deposit_expired, avg(deposit_interest) as average_interest from wizzard_deposits
where deposit_start_date > '1985-01-01'
group by deposit_group, is_deposit_expired
order by deposit_group desc, is_deposit_expired asc;
select * from employees order by department_id asc;
-- Using Database soft_uni
select department_id, min(salary) as minimum_salary from employees
where hire_date > '2000-01-01' and department_id in (2, 5, 7)
group by department_id
order by department_id asc;

-- 13
create temporary table high_paid_employees
select * from employees
where salary > 30000;

delete
from high_paid_employees
where manager_id = 42;

update high_paid_employees
set salary = salary + 5000
where department_id = 1;

select department_id, avg(salary) from high_paid_employees
group by department_id
order by department_id asc;

-- 14
select department_id, max(salary) as max_salary from employees
group by department_id
having max_salary not between 30000 and 70000
order by department_id asc;

-- 15
select count(salary) from employees
where manager_id is null;

-- 16
select distinct(department_id), salary from
( select department_id, salary, dense_rank() over (partition by department_id order by salary desc) as ranked_salary from employees)
as dense_ranked
where ranked_salary = 3
order by department_id asc;
-- 17
create temporary table avg_table
select department_id, avg(salary) as avg_salary from employees
group by department_id
order by department_id asc;

select first_name, last_name, e.department_id from employees as e
join avg_table as a on e.department_id = a.department_id
where salary > avg_salary
order by department_id, employee_id
limit 10;


select first_name, last_name, department_id from 
(
select first_name, last_name, department_id, employee_id, salary, avg(salary) over (partition by department_id) as avg_salary
from employees
) as data
where salary > avg_salary
order by department_id, employee_id
limit 10;

-- 18
select department_id, sum(salary) as total_sum from employees
group by department_id
order by department_id asc;
