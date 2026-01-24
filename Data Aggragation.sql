-- Using Database restaurant
-- 01
select department_id, count(*) as 'Number Of employees' from employees
group by department_id
order by department_id asc;

-- 02
select department_id, round(avg(salary), 2) as 'Average Salary' from employees
group by department_id
order by department_id;

-- 03
select department_id, round(min(salary), 2) as 'Min Salary' from employees
group by department_id
having `Min Salary` > 800;

-- 04
select count(*) as appetizers from products
where price > 8
group by category_id
having category_id = 2;

-- 05
select category_id, 
round(avg(price), 2) as 'Average Price',
round(min(price), 2) as 'Cheapest Product',
round(max(price), 2) as 'Most Expensive Product' from products
group by category_id;
