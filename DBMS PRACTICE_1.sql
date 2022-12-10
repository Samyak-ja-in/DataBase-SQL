use wings;
select * from employee;
select e_name,ssn,month(e_doj) as month from employee where month(e_doj) like 12; 
select count(*) from employee where e_name like "sa%";
select e_name,d_id,max(salary) from employee group by d_id ;
select count(e_gender) from employee where e_gender like "F";
select count(e_gender),e_gender from employee group by e_gender;
select * from department;
select e_name,max(salary),d_id from employee group by d_id;

-- 8(1) left join
select employee.d_id,d_name,avg(salary) from employee left join department on employee.d_id=department.d_id  group by employee.d_id;

select * from works;
select * from project;

-- 8(4)
select e_name,d_name,concat(e.street," ",e.city," ",e.state)as address  from employee as e join department as d on e.d_id=d.d_id where d_name='accounts';

-- 8(6)
select * from employee as e join department as d on e.d_id=d.d_id;
select count(d_id),d_id from employee group by(d_id);
select d_name,count(d_name) from employee as e join department as d on e.d_id=d.d_id group by(d_name);
-- 8(6)





create database practice;
use practice;
create table employee (e_id char(10),e_name varchar(20),e_doj date,salary bigint);
insert into employee values('1','samyak','2001-01-20',10000);
insert into employee values('2','harsh','2002-05-1',20000);
insert into employee values('3','samyak','2001-04-11',1000);
select * from employee order by e_name desc,salary desc;