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