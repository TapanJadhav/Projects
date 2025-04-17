create database a325;
show databases;
use a325;
create table student_information(
roll_no tinyint,
attendance bit,
pocket_money smallint);
show tables; # for showing the tables inside the selected database
describe student_information; # gives metadata or schema i.e. data about data
insert into student_information values(1,1,2000);
select *from student information;
insert into student_information values(255,2,326570),
(256,2,32786),
(32546,37896,38745);
select * from student_informatiom;
use a325;
create table product_id(
id int,
pho_no bigint,
price decimal(5,2));
describe product_id;
insert into product_id values(001,9967438678,500);
select * from product_id;
use a325;
create table fp_datatype(
id float,
re real);
describe fp_datatype;
insert into fp_datatype values(456118454845644.5411315443,444877895974564.54648846456);
select * from fp_datatype;
create table employee_data(
id int,
salary int,
work_hours decimal(2,1));
describe employee_data;
insert into employee_data values(1,20000,2.9),
(2,60000,4.6),
(3,50000,7.8),
(4,30000,3.2);
select * from employee_data;

create table dt(
dt date, ti time, dt_ti datetime);
insert into dt values('2025-04-16','09:48:50',"2025-04-16 09:48:50"); # yyyy-mm-dd
select*from dt;

create table student_c(
s_name char(10),sv_name varchar(10));
desc student_c;
insert into student_c values
("ABC","DEF");
select*from student_c;
create table student_demo(
roll int,
subject varchar(20),
addr varchar(20),
marks int);
insert into student_demo values
(1,"Python","Pune",56),
(2,"Java","Mumbai",95),
(3,"HTML","Nasik",85),
(4,"C","Pune",56),
(5,"Python","Nasik",50),
(6,"Django","Andheri",99),
(7,"Javascript","Banglore",85),
(8,null,"Pune",null);
select*from student_demo;
insert into student_demo(roll,addr) values(9,"Delhi"),
(10,"Mumbai");
select*from student_demo;
insert into student_demo values(11,"Django","Andheri",78),
(12,"Javascript","Banglore",45),
(13,"Python","Andheri",16),
(14,"Python","Pune",96);
select*from student_demo;
select roll,addr from student_demo;
select*from student_demo where roll=7;
select roll,subject,marks from student_demo where roll=7;
select roll,marks from student_demo where marks>=85;
select distinct addr from student_demo;

select distinct addr from student_demo
where addr like "%i"; 	#like clows % is any number ,_ is single character(first letter) 
select distinct addr from student_demo
where addr like "_u%";	 #ie second letter is u and % for any letter 
select distinct addr from student_demo
where addr like "M%";
select distinct addr from student_demo
where addr like "____i";	# (5 letter addr ending with i)
select distinct addr from student_demo
where addr not like "____i";
select roll,marks from student_demo;	 # without (5 letter addr ending with i)

select roll,marks from student_demo
order by marks desc limit 3;	 # top 3 students
select roll,marks from student_demo
where marks is not null
order by marks limit 1;	 # lowest scorerer

select roll,marks from student_demo 
order by marks desc limit 1,2; # limit with condtion

#constraints
/*
In sql constraints are used to specify rules for the data in a table.They are used to limit type of data that can go into a table and ensures accuracy & reliability.
>>  There are different kinds of constraints in sql:-
	1. Unique - Ensures that all the values in column are different.
	2. not null - ensures that column can not have a null value.
	3. Primary key - Combinatttion of not null & unique, identifies each row in a table.
	4. Foreign key - A column or set of column refferences primary key of another or same table creating a link or relationship betweenn 2 tables.
				This establishes relationship, where data in foreign key column can only refer to the values in the refrenced primary key column ensuring data integrity and consistency.
				The referncial integrity means foreign key column in one table can only contain values that exist in primary key column of the related table.
	5. Data - Ensures data accuracy across related tables.
	6. Check - Ensures taht the values in a column satisfies a specific condition.
	7. Default - Sets a diffault value for a column if no value is specified.
*/