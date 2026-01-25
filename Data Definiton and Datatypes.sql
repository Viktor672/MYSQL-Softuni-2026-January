-- 00
create database gamebar;

-- 01
create table employees
(
id int primary key auto_increment,
first_name varchar(50) not null,
last_name varchar(50) not null
);

create table categories
(
id int primary key auto_increment,
`name` varchar(50) not null
);

create table products
(
id int primary key auto_increment,
`name` varchar(50) not null,
category_id int not null
);

-- 02
insert into employees (first_name, last_name)
values
('Peter', 'Petrov'),
('Pesho', 'Peshev'),
('Dimitar', 'Dimitrov');

-- 03
alter table employees
add column middle_name varchar(50);

-- 04
alter table employees
modify column middle_name varchar(100);