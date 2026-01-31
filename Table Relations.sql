-- Using database camp

-- 01
create table mountains (
id int unsigned primary key auto_increment,
name varchar(50)
);

create table peaks (
id int unsigned primary key auto_increment,
name varchar(50),
mountain_id int unsigned,
constraint foreign key (mountain_id) references mountains(id)
);

-- 02
select v.driver_id, v.vehicle_type, concat(c.first_name, ' ', c.last_name) as driver_name from vehicles as v
join campers as c on c.id = v.driver_id;

-- 03
select r.starting_point, r.end_point, c.id, concat(c.first_name, ' ', c.last_name) from routes as r
join campers as c on r.leader_id = c.id;

-- 04
drop table mountains;
drop table peaks;

create table mountains(
id int unsigned primary key auto_increment,
name varchar(50)
);

create table peaks (
id int unsigned primary key auto_increment,
name varchar(50),
mountain_id int unsigned,
constraint foreign key (mountain_id) references mountains(id) on delete cascade
);

-- 05
create database demo;

-- Using database demo
create table clients(
id int unsigned primary key auto_increment,
client_name varchar(100)
);

create table projects (
id int unsigned primary key auto_increment,
client_id int unsigned,
project_lead_id int unsigned,
constraint foreign key (client_id) references clients(id)
);

create table employees (
id int unsigned primary key auto_increment,
first_name varchar(30),
last_name varchar(30),
project_id int unsigned,
constraint foreign key (project_id) references projects(id)
);

alter table projects
add foreign key (project_lead_id) references employees(id);