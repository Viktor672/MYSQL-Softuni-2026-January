-- Using Database soft_uni

-- 01
select e.employee_id, concat(e.first_name, ' ', e.last_name), d.department_id, d.name from employees as e
join departments as d
on e.employee_id = d.manager_id
order by employee_id asc
limit 5;

-- 02
select t.town_id, t.`name`, a.address_text from towns as t
join addresses as a
on t.town_id = a.town_id
where t.`name` in ('San Francisco', 'Sofia', 'Carnation')
order by t.town_id asc, a.address_id asc;

-- 03
select employee_id, first_name, last_name, department_id, salary from employees
where manager_id is null;

-- 04
select count(salary) from employees
where salary > (select avg(salary) from employees);