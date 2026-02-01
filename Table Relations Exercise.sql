create database table_relations_exercise;

-- 01
-- Using Database table_relations_exercise
create table passports (
passport_id int unsigned primary key auto_increment,
passport_number varchar(50) not null unique
);

create table people (
person_id int unsigned primary key auto_increment,
first_name varchar(50),
salary decimal(10,2),
passport_id int unsigned not null unique,
constraint foreign key (passport_id) references passports(passport_id)
);

insert into passports
values
(101, 'N34FG21B'),
(102, 'K65LO4R7'),
(103, 'ZE657QP2');

insert into people 
values
(1, 'Roberto', 43300, 102),
(2, 'Tom', 56100, 103),
(3, 'Yana', 60200, 101);

-- 02
create table manufacturers (
manufacturer_id int unsigned primary key auto_increment,
name varchar(20) not null unique,
established_on date
);

create table models (
model_id int unsigned primary key auto_increment,
name varchar(30) not null,
manufacturer_id int unsigned,
constraint foreign key (manufacturer_id) references manufacturers(manufacturer_id)
);

insert into manufacturers 
values
(1, 'BMW', '1916-03-01'),
(2, 'Tesla', '2003-01-01'),
(3, 'Lada', '1966-05-01');

insert into models
values
(101, 'X1', 1),
(102, 'i6', 1),
(103, 'Model S', 2),
(104, 'Model X', 2),
(105, 'Model 3', 2),
(106, 'Nova', 3);

-- 03
create table students (
student_id int unsigned primary key auto_increment,
name varchar(30) not null
);

create table exams (
exam_id int unsigned primary key auto_increment,
name varchar(50) not null unique
);

create table students_exams (
student_id int unsigned,
exam_id int unsigned,
constraint primary key (student_id, exam_id),
constraint foreign key (student_id) references students(student_id),
constraint foreign key (exam_id) references exams(exam_id)
);

insert into students
values
(1, 'Mila'),
(2, 'Toni'),
(3, 'Ron');

insert into exams
values
(101, 'Spring MVC'),
(102, 'Neo4j'),
(103, 'Oracle 11g');

insert into students_exams
values
(1, 101),
(1, 102),
(2, 101),
(3, 103),
(2, 102),
(2, 103);

-- 04
create table teachers (
teacher_id int unsigned primary key auto_increment,
name varchar(30) not null,
manager_id int unsigned
);

insert into teachers
values
(101, 'John', null),
(102, 'Maya', 106),
(103, 'Silvia', 106),
(104, 'Ted', 105),
(105, 'Mark', 101),
(106, 'Greta', 101);

alter table teachers
add foreign key (manager_id) references teachers(teacher_id);

-- 05
create database online_store;

-- Using Database online_store
create table cities (
city_id int unsigned primary key auto_increment,
name varchar(50)
);

create table customers (
customer_id int unsigned primary key auto_increment,
name varchar(50),
birthday date,
city_id int unsigned,
constraint foreign key (city_id) references cities(city_id)
);

create table orders (
order_id int unsigned primary key auto_increment,
customer_id int unsigned,
constraint foreign key (customer_id) references customers(customer_id)
);

create table item_types (
item_type_id int unsigned primary key auto_increment,
name varchar(50)
);

create table items (
item_id int unsigned primary key auto_increment,
name varchar(50),
item_type_id int unsigned,
constraint foreign key (item_type_id) references item_types(item_type_id)
);

create table order_items (
order_id int unsigned,
item_id int unsigned,
constraint primary key (order_id, item_id),
constraint foreign key (order_id) references orders(order_id),
constraint foreign key (item_id) references items(item_id)
);

-- 06
create table subjects (
subject_id int primary key auto_increment,
subject_name varchar(50) not null
);

create table majors(
major_id int primary key auto_increment,
name varchar(50) not null
);

create table students(
student_id int primary key auto_increment,
student_number varchar(12) not null unique,
student_name varchar(50) not null,
major_id int,
constraint foreign key (major_id) references majors(major_id)
);

create table payments (
payment_id int primary key auto_increment,
payment_date date,
payment_amount decimal(8, 2),
student_id int,
constraint foreign key (student_id) references students(student_id)
);

create table agenda(
student_id int,
subject_id int,
primary key(student_id, subject_id),
constraint foreign key (student_id) references students(student_id),
constraint foreign key (subject_id) references subjects(subject_id)
);

-- 09
select * from mountains;
select * from peaks;

select m.mountain_range, p.peak_name, p.elevation
from mountains as m
join peaks as p
on m.id = p.mountain_id
where m.mountain_range = 'Rila'
order by p.elevation desc;