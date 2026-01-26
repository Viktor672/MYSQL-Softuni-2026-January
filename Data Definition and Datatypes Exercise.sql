SET SQL_SAFE_UPDATES = 0;

-- 00
create database minions;

-- 01
create table minions 
(
id int primary key auto_increment,
`name` varchar(50),
age int
);

create table towns
(
town_id int primary key auto_increment,
`name` varchar(50)
);

-- 02
alter table minions
add column town_id int,
add foreign key (town_id) references towns(id);

-- 03
insert into towns (id, `name`)
values
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna');

insert into minions (id, `name`, age, town_id)
values
(1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', null, 2);

-- 04
truncate table minions;

-- 05
drop table minions;
drop table towns;

-- 06
create table people (
id bigint unsigned primary key auto_increment,
`name` varchar(200) not null,
picture blob null,
height decimal(5,2) null,
weight decimal(5,2) null,
gender enum('m', 'f') not null,
birthdate date not null,
biography text null
);
create table people (
    id bigint unsigned primary key auto_increment,
    name varchar(200) not null ,
    picture blob null,
    height decimal(5,2) null,
    weight decimal(5,2) null,
    gender enum('m','f') not null,
    birthdate date not null ,
    biography text null
);

insert into people
values
(1, 'Peter Petrov', null, 1.80, 79.4, 'm', '1998-02-04', 'He is an Engineer.'),
(2, 'Pesho Peshev', null, 1.93, 98.89, 'm', '1993-03-01', 'He is a Mathematician.'),
(3, 'Maria Mihaileva', null, 1.59, 43.93, 'f', '1999-01-12', 'She is a Teacher.'),
(4, 'Petq Ninova', null, 1.70, 63.4, 'f', '2001-05-26', 'She is a Designer.'),
(5, 'Dimitar Dimitrov', null, 1.75, 71.32, 'm', '2003-06-21', 'He is a Doctor.');

-- 07
create table users (
id bigint unsigned primary key auto_increment,
username varchar(30) character set ascii not null unique,
password varchar(26) character set ascii not null,
profile_picture mediumblob,
last_login_time datetime,
is_deleted boolean
);

insert into users
values
(1, 'Peter', 'somepass', null, '2025-08-18 22:01:13', false),
(2, 'Pesho', '123pass321', null, '2025-08-16 14:32:23', false),
(3, 'Maria', 'testpass', null, '2025-08-18 17:56:09', false),
(4, 'Petq', 'otherpass', null, '2025-07-10 13:12:27', true),
(5, 'Dimitar', 'morepass', null, '2025-08-16 19:43:36', false);

-- 08
alter table users
drop primary key,
add constraint pk_users primary key(id, username);

-- 09
alter table users
modify last_login_time datetime default current_timestamp;

-- 10
alter table users
drop primary key,
add constraint pk_users primary key(id),
add constraint uq_users_username unique(username);

-- 11
create schema movies;

create table directors (
id int unsigned primary key auto_increment ,
director_name varchar(50) not null,
notes text
);

create table genres (
id int unsigned primary key auto_increment,
genre_name varchar(50) not null,
notes text
);

create table categories (
id int unsigned primary key auto_increment,
category_name varchar(50) not null,
notes text
);

create table movies(
id int unsigned primary key auto_increment,
title varchar(50) not null,
director_id int unsigned,
copyright_year year,
`length` smallint unsigned,
genre_id int unsigned,
category_id int unsigned,
rating decimal(7,2),
notes text
);

INSERT INTO directors
VALUES 
(1,'Christopher Nolan', 'Known for non-linear storytelling and blockbusters like Inception and Oppenheimer.'),
(2, 'Steven Spielberg', 'One of the founding fathers of the New Hollywood era, famous for Jurassic Park.'),
(3, 'Quentin Tarantino', 'Renowned for stylized violence, sharp dialogue, and pop culture references.'),
(4, 'Martin Scorsese', 'A master of the crime and gangster genres, famous for Goodfellas and The Departed.'),
(5, 'Greta Gerwig', 'Acclaimed for her distinct voice in modern cinema with films like Lady Bird and Barbie.');

INSERT INTO genres 
VALUES 
(1, 'Sci-Fi', 'Science Fiction movies involving futuristic concepts and technology.'),
(2, 'Drama', 'Focuses on the emotional and relational development of realistic characters.'),
(3, 'Action', 'Characterized by high energy, physical stunts, and continuous movement.'),
(4, 'Horror', 'Designed to elicit fear, terror, and suspense in the audience.'),
(5, 'Comedy', 'Aims to entertain and provoke laughter through humor and wit.');

INSERT INTO categories
VALUES 
(1, 'Feature Film', 'Full-length movies produced for theatrical or streaming release.'),
(2, 'Short Film', 'Motion pictures with a running time of 40 minutes or less.'),
(3, 'Documentary', 'Non-fictional motion pictures intended to document reality.'),
(4, 'Animation', 'Films where individual drawings or models are photographed or created digitally.'),
(5, 'TV Series', 'A sequence of episodes that are broadcast over a period of time.');

INSERT INTO movies
VALUES 
(1, 'Inception', 1, 2010, 148, 1, 1, 8.8, 'A thief who steals corporate secrets through the use of dream-sharing technology.'),
(2, 'Jurassic Park', 2, 1993, 127, 3, 1, 8.2, 'A pragmatic paleontologist visiting an almost complete theme park is tasked with protecting kids.'),
(3, 'Pulp Fiction', 3, 1994, 154, 4, 1, 8.9, 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine.'),
(4, 'Goodfellas', 4, 1990, 145, 2, 1, 8.7, 'The story of Henry Hill and his life in the mob, covering his relationship with his wife and partners.'),
(5,'Barbie', 5, 2023, 114, 5, 1, 6.9, 'Barbie suffers a crisis that leads her to question her world and her existence.');


-- 12
create schema car_rental;

create table categories (
    id int unsigned primary key auto_increment,
    category varchar(50) not null,
    daily_rate decimal(10,2) not null,
    weekly_rate decimal(10,2) not null,
    monthly_rate decimal(10,2) not null,
    weekend_rate decimal(10,2) not null
);

create table cars (
    id int unsigned primary key auto_increment,
    plate_number varchar(20) not null,
    make varchar(50) not null,
    model varchar(50) not null,
    car_year int unsigned not null,
    category_id int unsigned not null,
    doors int unsigned not null,
    picture blob null,
    car_condition varchar(50) not null,
    available tinyint not null
);

create table employees (
    id int unsigned primary key auto_increment,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    title varchar(50) not null,
    notes text null
);

create table customers (
    id int unsigned primary key auto_increment,
    driver_licence_number varchar(30) not null,
    full_name varchar(100) not null,
    address varchar(100) not null,
    city varchar(50) not null,
    zip_code varchar(20) not null,
    notes text null
);

create table rental_orders (
    id int unsigned primary key auto_increment ,
    employee_id int unsigned not null,
    customer_id int unsigned not null,
    car_id int unsigned not null,
    car_condition varchar(50) not null,
    tank_level decimal(5,2) not null,
    kilometrage_start int unsigned not null,
    kilometrage_end int unsigned not null,
    total_kilometrage int unsigned not null,
    start_date date not null,
    end_date date not null,
    total_days int unsigned not null,
    rate_applied decimal(10,2) not null,
    tax_rate decimal(10,2) not null,
    order_status varchar(20) not null,
    notes text null
);

INSERT INTO categories (category, daily_rate, weekly_rate, monthly_rate, weekend_rate)
VALUES 
('Standard', 50.00, 300.00, 1100.00, 65.00),
('Business', 85.00, 550.00, 2000.00, 110.00),
('Luxury', 150.00, 950.00, 3500.00, 200.00);

INSERT INTO cars (plate_number, make, model, car_year, category_id, doors, picture, car_condition, available)
VALUES 
('CB1234AB', 'Toyota', 'Corolla', 2022, 1, 4, NULL, 'Excellent', 1),
('B5566KT', 'BMW', '5 Series', 2023, 2, 4, NULL, 'New', 1),
('A0001AA', 'Mercedes-Benz', 'S-Class', 2024, 3, 4, NULL, 'Showroom', 0);

INSERT INTO employees (first_name, last_name, title, notes)
VALUES 
('John', 'Doe', 'Manager', 'Experienced in fleet management and customer relations.'),
('Jane', 'Smith', 'Sales Representative', 'Fluent in English and Spanish, handles luxury car rentals.'),
('Michael', 'Brown', 'Mechanic', 'Responsible for technical inspections and maintenance.');

INSERT INTO customers (driver_licence_number, full_name, address, city, zip_code, notes)
VALUES 
('B12345678', 'Alice Johnson', '123 Maple Avenue', 'New York', '10001', 'Long-term corporate client.'),
('C98765432', 'Bob Wilson', '456 Oak Street', 'London', 'SW1A 1AA', 'Prefers automatic transmission cars.'),
('D55443322', 'Elena Rossi', 'Via Roma 12', 'Rome', '00100', NULL);

INSERT INTO rental_orders (
    employee_id, customer_id, car_id, car_condition, tank_level, 
    kilometrage_start, kilometrage_end, total_kilometrage, 
    start_date, end_date, total_days, rate_applied, tax_rate, 
    order_status, notes
) 
VALUES 
(1, 1, 1, 'Good', 100.00, 15000, 15250, 250, '2026-01-10', '2026-01-15', 5, 250.00, 50.00, 'Completed', 'Client returned the car on time.'),
(2, 2, 2, 'Excellent', 85.50, 5200, 5800, 600, '2026-02-01', '2026-02-08', 7, 550.00, 110.00, 'Active', 'Extended rental period.'),
(1, 3, 3, 'New', 100.00, 120, 120, 0, '2026-03-01', '2026-03-03', 2, 300.00, 60.00, 'Pending', 'Waiting for pickup.');



-- 13
create schema soft__uni;

create table towns (
    id int unsigned primary key auto_increment,
    name varchar(50) not null
);

create table addresses (
    id int unsigned primary key auto_increment,
    address_text varchar(100) not null,
    town_id int unsigned not null,
    foreign key (town_id) references towns(id)
);

create table departments (
    id int unsigned primary key auto_increment,
    name varchar(50) not null
);

create table employees (
    id int unsigned primary key auto_increment,
    first_name varchar(50) not null,
    middle_name varchar(50) null,
    last_name varchar(50) not null,
    job_title varchar(50) not null,
    department_id int unsigned not null,
    hire_date date not null,
    salary decimal(10,2) not null,
    address_id int unsigned not null,

     foreign key (department_id) references departments(id),
     foreign key (address_id) references addresses(id)
);

insert into towns (name)
values
    ('Sofia'),
    ('Plovdiv'),
    ('Varna'),
    ('Burgas');

insert into addresses (address_text, town_id)
values
    ('1 Vitosha Blvd', 1),
    ('15 Tsar Simeon Str', 2),
    ('8 Primorski Blvd', 3),
    ('22 Aleksandrovska Str', 4),
    ('10 Dondukov Blvd', 1);

insert into departments (name)
values
    ('Engineering'),
    ('Sales'),
    ('Marketing'),
    ('Software Development'),
    ('Quality Assurance');

insert into employees (
    first_name, middle_name, last_name, job_title, department_id, hire_date, salary, address_id
)
values
    ('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00, 1),
    ('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00, 2),
    ('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25, 3),
    ('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00, 4),
    ('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88, 5);
    
-- 14
select * from towns;
select * from departments;
select * from employees;

-- 15
select * from towns
order by name asc;

select * from departments
order by name asc;

select * from employees
order by salary desc;

-- 16
select `name` from towns
order by name asc;

select `name` from departments
order by name asc;

select first_name, last_name, job_title, salary from employees
order by salary desc;

-- 17
update employees
set salary = salary * 1.1;

select salary from employees;

    
    









