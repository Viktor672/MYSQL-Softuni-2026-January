-- 01
select id, first_name, last_name, job_title from employees
order by id asc;

-- 02
select id, concat(first_name, ' ', last_name) as full_name, job_title, salary from employees
where salary > 1000
order by id asc;

-- 03
update employees
set salary = salary + 100
where job_title = 'Manager';

select salary from employees;

-- 04
create view `select_biggest_salary` as
select * from employees
order by salary desc
limit 1;

-- 05
select * from employees
where department_id = 4 and salary >= 1000
order by id asc;

-- 06
delete from employees
where department_id in (1, 2);

select * from employees
order by id asc;
