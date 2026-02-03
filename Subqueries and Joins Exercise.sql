-- Using Database soft_uni

-- 01
select e.employee_id, e.job_title, e.address_id, a.address_text from employees as e
join addresses as a
on e.address_id = a.address_id
order by a.address_id asc
limit 5;

-- 02
select e.first_name, e.last_name, t.`name`, a.address_text from employees as e
join addresses as a
on e.address_id = a.address_id
join towns as t
on t.town_id = a.town_id
order by e.first_name asc, e.last_name asc
limit 5;

-- 03
select e.employee_id, e.first_name, e.last_name, d.`name` from employees as e
join departments as d
on d.department_id = e.department_id
where d.name = 'Sales'
order by e.employee_id desc;

-- 04
select e.employee_id, e.first_name, e.salary, d.`name` from employees as e
join departments as d
on d.department_id = e.department_id
where e.salary > 15000
order by d.department_id desc
limit 5;

-- 05
select e.employee_id, e.first_name from employees as e
left join employees_projects as ep
on e.employee_id = ep.employee_id
where ep.project_id is null
order by e.employee_id desc
limit 3;

-- 06
select e.first_name, e.last_name, e.hire_date, d.`name` as dept_name from employees as e
join departments as d
on e.department_id = d.department_id
where hire_date >= '1999-01-02' and d.`name` in ('Sales', 'Finance')
order by hire_date asc;

-- 07
select e.employee_id, e.first_name, p.`name` from employees as e
join employees_projects as ep
on e.employee_id = ep.employee_id
join projects as p
on ep.project_id = p.project_id
where p.start_date >= '2002-08-14' and p.end_date is null
order by e.first_name asc, p.`name` asc
limit 5;

-- 08
select e.employee_id, e.first_name, 
if(year(p.start_date) >= 2005, null, p.`name`) as project_name from employees as e
join employees_projects as ep
on e.employee_id = ep.employee_id
left join projects as p
on ep.project_id = p.project_id
where e.employee_id = 24
order by project_name;

-- 09
select e.employee_id, e.first_name, e.manager_id, m.first_name from employees as e
join employees as m
on e.manager_id = m.employee_id
where e.manager_id = 3 or e.manager_id = 7
order by e.first_name asc;

-- 10
select e.employee_id,
concat_ws(' ', e.first_name, e.last_name),
concat_ws(' ', m.first_name, m.last_name),
d.`name` 
from employees as e
join employees as m
on e.manager_id = m.employee_id
join departments as d
on e.department_id = d.department_id
order by e.employee_id asc
limit 5;

-- 11
-- Option 1
with avg_salary as (
select avg(salary) as average_salary from employees
group by department_id
)
select min(average_salary) as minimum_average_salary from avg_salary;

-- Option 2
select min(average_salary) as minimum_average_salary
from (
select avg(salary) as average_salary from employees
group by department_id
) as avg_salary;

-- Using Database geography
-- 12
select c.country_code, m.mountain_range, p.peak_name, p.elevation from countries as c
join mountains_countries as mc
on c.country_code = mc.country_code
join mountains as m
on m.id = mc.mountain_id
join peaks as p
on m.id = p.mountain_id
where c.country_code = 'BG' and p.elevation > 2835
order by p.elevation desc;

-- 13
select c.country_code, count(m.mountain_range) as 'mountain_range' from countries as c
join mountains_countries as mc
on c.country_code = mc.country_code
join mountains as m
on m.id = mc.mountain_id
where c.country_code in ('US', 'RU', 'BG')
group by c.country_code
order by `mountain_range` desc;

-- 14
select c.country_name, r.river_name from countries as c
left join countries_rivers as cr
on c.country_code = cr.country_code
left join rivers as r
on r.id = cr.river_id
where c.continent_code = 'AF'
order by c.country_name asc
limit 5;

-- 15
select continent_code, currency_code, currency_usage from 
(select continent_code, currency_code, currency_usage,
dense_rank() over (partition by continent_code order by currency_usage desc) as dense_ranked from
(select continent_code, currency_code, count(currency_code) as currency_usage from countries
group by continent_code, currency_code 
having currency_usage > 1
order by  continent_code asc) as filtered_data) as ranked
where dense_ranked = 1
order by continent_code asc, currency_code asc;

-- 16
select count(*) from countries as c
left join mountains_countries as mc
on c.country_code = mc.country_code
left join mountains as m
on m.id = mc.mountain_id
where m.id is null;

-- 17
select c.country_name,
max(p.elevation) as highest_peak_elevation,
max(r.length) as longest_river_length
from countries as c
left join mountains_countries as mc
on c.country_code = mc.country_code
left join mountains as m
on mc.mountain_id = m.id
left join peaks as p
on m.id = p.mountain_id
left join countries_rivers as cr
on c.country_code = cr.country_code
left join rivers as r
on r.id = cr.river_id
group by c.country_name
order by highest_peak_elevation desc, longest_river_length desc, c.country_name asc
limit 5;
