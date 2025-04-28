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
In sql constraints are used to specify rules for the data in a table.
They are used to limit type of data that can go into a table and ensures accuracy & reliability.
>>  There are different kinds of constraints in sql:-
	1. Unique - Ensures that all the values in column are different.
	2. not null - Ensures that column can not have a null value.
	3. Primary key - Combination of not null & unique, identifies each row in a table.
	4. Foreign key - A column or set of column refferences primary key of another or same table creating a link or relationship betweenn 2 tables.
					This establishes relationship, where data in foreign key column can only refer to the values in the refrenced primary key column,
                    ensuring data integrity and consistency.
					The referncial integrity means foreign key column in one table can only contain values that exist in primary key column
                    of the related table.
	5. Data - Ensures data accuracy across related tables.
	6. Check - Ensures that the values in a column satisfies a specific condition.
	7. Default - Sets a diffault value for a column if no value is specified.
*/

use a325;
create table c(
id int);
insert into c values("A");

			# example for unique constraints
create table u(id int unique, name varchar(30));
insert into u values(1,"Harry");
select*from u;
insert into u values(2,"Harry");
desc u;
select*from u;
insert into u values(null,"Harry"); # unique key does not interact with (null)
insert into u values(null,"Jerry"); # it can be repeated data of null(garbage/random) entries

			# example for null key constraints
create table n(id int not null, name varchar(30));
desc n;
insert into n values(0,"Harry");
select*from n;
insert into n values(0,"Harry");
select*from n;
insert into n values(null,"Harry");
select*from n;
insert into n values(0,null);
select*from n;

			# example for primary key constraints
create table u_n(id int unique not null, name varchar(30));
desc u_n;
create table n(id int not null, name varchar(30));
desc n;

create table po(adh_no int unique not null, pan_no varchar(30) unique not null, passport int unique not null);
desc po;
insert into po values(29,"tpj786",7856),(18,"dnk657",6553),(07,"std666",8679);
select*from po;
drop table po;
create table pop(adh_no int unique not null, pan_no varchar(30) unique not null, passport int unique not null);
desc pop;
insert into pop values(29,"tpj786",7856),(18,"dnk657",6553),(07,"std666",8679),(07,"ybs466",6235);

			# example for auto_increment
create table a(id int primary key auto_increment, name varchar(10)); # auto_increment only operates with primary key constraint
desc a;
insert into a values(107,"Tapan");
insert into a(name) values("Raj"),("Yash"),("Saurabh"),("Dev"),("Rohit");
select*from a;
			# example for check key constraint [only not null key has to be writtern within the data entry]
create table x(id int primary key, age int, name varchar(20), check (age>18));
desc x;
insert into x values(1,20,"Yo");
select*from x;

create table y(id int primary key, age int check (age>18), name varchar(20));
desc y;
insert into y values(1,65,"John Cena");
select*from y;
show create table y;

			# example for default key constraint
create table d(id int, name varchar(20), city varchar(20) default "Mumbai");
desc d;
insert into d values(1,"Raj","Pune");
select*from d;
insert into d(id,name) values(1,"Vipul");
select*from d;

			# example for foreign key constraint [MUL]
create table customers(id int primary key, name varchar(20));  # parent table (which comtains primary key)
create table orders(o_id int primary key, c_id int, constraint fo foreign key(c_id) references customers(id)); # child table
desc customers;
desc orders;
# child table insertion
 insert into customers values(1,"Raj");
 insert into orders values(10,1);
 select*from customers;
 select*from orders;
# parent table deletion
delete from customers where id=1;  # can not delete or update parent table when child table is reffenced with parent table
delete from orders where c_id=1;
delete from customers where id=1;
select*from customers;
insert into customers values(2,"Rajesh");
delete from customers where id=2;
use a325;
create table pizza_types(type_id int primary key, name varchar(50), category varchar(50));
insert into pizza_types values(1,"The Barbeque Pizza","Veg");
describe pizza_types;
select*from pizza_types;

use a325;
create table Customer(customer_id int primary key, first_name varchar(100), last_name varchar(100), age int, country varchar(100));
describe Customer;
create table Orders(order_id integer, item varchar(100), amount integer, customer_id integer, constraint fk foreign key(c_id) references customer(id));
describe Orders; 

create table product_demo(id int, name varchar(20), price int);
describe product_demo;
alter table product_demo rename product1;
describe product1;
alter table product1 modify name varchar(50);					# use modify function to change the datatype
describe product1;
alter table product1 modify name varchar(50) not null;					
describe product1;
alter table product1 add constraint chk_price check(price>0);				# use add function to add constraints to existing table
describe product1;
alter table product1 modify name varchar(50) default "Ariel";			
alter table product1 modify price decimal(5,2) not null default 100.00;			# multiple functions can be applied using modify function
describe product1;
alter table product1 add column email_id varchar(100) after id;
alter table product1 change column id pid int;
alter table product1 change column price product_price int;
alter table product1 drop check chk_price;
alter table product1 add primary key(pid);						#null function gets added by default when adding primary key
alter table product1 drop primary key;							#null function does not get removed after removing primary key
describe product1;
insert into product1 values(null,"April",234.78);
describe product1;
alter table product1 modify pid int;
insert into product1 values(null,"April",234.78);

create table course_p(id int primary key, sname varchar(20));
create table stud_p(sid int primary key, cid int);
alter table stud_p add constraint stud_p_fk foreign key(cid) references course_p(id);	#add foreign key in existing table
describe course_p;
describe stud_p;
insert into stud_p values(1,10);		#error "values cannot be added into child table because of invalid references in parent table(rule of foreign key)"
insert into course_p values(10,"April");
insert into stud_p values(1,10);
insert into stud_p values(1,20);		#error bcuz foreign key is present in the child table
delete from course_p;					#can not delete from parent table when valaues in child table are present
delete from stud_p where cid=10;		#delete values from child table first then delete from parent table
delete from course_p where id=0;
select*from course_p;
select*from stud_p;

alter table stud_p drop constraint stud_p_fk;
describe stud_p;
insert into stud_p values(1,20);		#no error as foreign key is deleted from the child table
select*from stud_p;

# Functions (text, date, maathematical functions, etc)
				# text functions
create table str_demo(f_name varchar(20),l_name varchar(20));
insert into str_demo values("Tom","JeRRy"),("hArry","poTTer");
select concat(f_name," ",l_name) name from str_demo;
select upper(f_name),lower(l_name),length(f_name) from str_demo;

select replace("Let us earn SQl","earn","learn") Replacement;
select substr("Let us earn SQL",8,4);

				#mqths functions
select round(1234.561789,2);			#rounds of the value & shows 0 before . deimal
select round(1234.56789,-3);			
select truncate(1234.56789,2);
select truncate(1234.56789,-2);
select floor(77.7);				#
select ceil(77.7);
select pow(2,3),sqrt(77),mod(29,3);
select isnull(1*1), isnull(1*0), isnull(1/0), isnull(0/1);
select coalesce(null, null, null, 07, null);
select coalesce(null, null, null, null, null);
create table aggregate_functions(i int);
insert into aggregate_functions values(1),(2),(3),(4),(5);
select max(i),min(i),count(i),avg(i),sum(i) from aggregate_functions;
select count(*) from aggregate_functions;
select greatest(1,7,100,29), least(1,7,100,29);
use a325; 

				#date functions
select current_date();
select date_format(current_date(),("%Y-%M-%D")) as Formatted_date;
select current_date() as Today,
	date_add(current_date(),interval 7 day) as Exam_Date,
    date_sub(current_date(),interval 1 month) as Last_Month_Date;
select datediff(current_date(),"2024-05-24");

select case 
		when current_date>"2025-05-29" then "Quarter 2"
        else "Quarter 1"
        end as Quarter_Comparision; 	#example case
select current_time(),now();
select dayofweek(current_date());
select last_day (current_date());
select extract(year from now()) Year,
		extract(month from now()) Month,
        extract(day from now()) Day,
        extract(hour from now()) Hour,
        extract(minute from now()) Minute,
        extract(Second from now()) Second;
select extract(year from "2025-04-24") Year,
		year("2025-04-24"),
        month("2025-04-24"),
        day("2025-04-24");
select sysdate();

				#groups by having
use new_data_gh;
show tables;
describe cust_gh;
select*from cust_gh;
select distinct country from cust_gh;
select country, count(*) from cust_gh 
	group by country;
select*from cust_gh 
	group by country;
select country, avg(age) from cust_gh 
	group by country;
select country, avg(age), min(age), max(age), count(age) from cust_gh 
	group by country; 										#in having clause function should be just right after having clause
select country, avg(age) from cust_gh 
	group by country 
    having avg(age)>25;										#having clause for applying conditions on group
select country, avg(age) from cust_gh 
	group by country 
    having avg(age)>25 and count(*)>2;
select country, avg(age) from cust_gh 
	group by country 
    having avg(age)>25 
    order by avg(age);										#order by clause
select country, avg(age) from cust_gh 
	where country like "U%"
    group by country 
    having avg(age)>25 
    order by avg(age);										#where clause combined with group by having functions
    
show tables;
describe employee_copy;
describe employee_sq;
select emp_salary from employee_sq order by emp_salary desc limit 1;
select max(emp_salary) from employee_sq;
select emp_dept, emp_salary from employee_sq where emp_salary = 113000;
select emp_dept, emp_salary from employee_sq where emp_salary =(select max(emp_salary) from employee_sq); 		#subquerry query(query)
select*from employee_sq where emp_salary> (select avg(emp_salary) from employee_sq);
select*from employee_sq where emp_age> (select min(emp_age) from employee_sq);
select min(emp_age) from employee_sq;
select*from employee_sq where emp_id in (select (emp_id) from employee_sq);
select*from employee_sq where emp_id in (select (emp_id) from employee_sq 
			where emp_age> (select min(emp_age) from employee_sq));					#
select*from employee_sq where emp_id in (select (emp_id) from employee_sq 
			where emp_age> (select avg(emp_age) from employee_sq)); 				#

update employee_sq set emp_salary=emp_salary+3000  
	where emp_id in (select emp_id from employee_copy where emp_age>25);
delete from employee_sq where emp_id in (select emp_id from employee_copy where emp_age>25);

select*from products;
select*from orders;
select prod_id from products where prod_price>1000;
select prod_id, prod_price from products where prod_price>1000;

insert into orders 
select prod_id, prod_name, prod_price from products 
where prod_id in (select prod_id from products where prod_price>1000);

select*from teacher;
select*from student;

select age from teacher where age > all(select sage from student);
select age from teacher where age > any(select sage from student);

select age from teacher where exists (select sage from student where sage>31);