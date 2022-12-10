create database learn;
use learn;
create table person(
	pid int,
    pname varchar(50),
    pdob date,
    page int,
    pgender char(1)
    );

insert into person values(4,"sanyam",'2008-09-04',11,'M');


-- INSERTING MULTIPLE VALUES IN TABLE AT ONCE
insert into person values
(5,"kanha",'2007-09-01',12,"M"),
(6,"shyam",'2001-09-01',21,"M"),
(7,"kuku",'2004-09-01',11,"M");
--  --------------------------------

-- AUTOMATICALLY NULL VALUE GETS FED IF NOTHING WRITTEN BUT IT IS IMPORTANT FOR US TO HAVE VALUE IN AGE HENCE WE USE CONSTRAINS
-- LIKE NOT NULL UNIQUE DEFAULT CHECK etc
insert into person (pid,pname,pdob,pgender)
values(7,"Seema",'1998-01-20','F');
select * from person;

-- CREATING NEW TABLES WITH CONSTRAINS
create table friend(
fid int not null unique,
fname varchar(50) not null ,
fgender char(1) not null check(fgender in ('M','F')),
fcity char(20) default 'chomu'); 


-- WE CAN USE AUTOINCREMENT AND IT HAVE VALUE OF 1 BY DEFAULT
create table auto(
pid int not null auto_increment primary key,
pname char(50) not null);

insert into friend (fid,fname,fgender)
values
(1,"parag",'M'),
(2,"harsh",'M'),
(3,'risabh','M'),
(4,'rupal','F'),
(5,'gaman','M');

insert into friend 
values
(6,'mansvi','F','jodhpur');

insert into friend (fid,fname,fgender)
values
(7,'sagar','M'),
(8,'mayank','M');

insert into friend
values
(9,"samyak",'M','chomu');

insert into friend (fid,fgender,fcity) values
(9,'F','chomu');
select * from friend;

drop table friend;

insert into auto (pname) values
('shyam'),
('ghanshyam');

select * from auto;
-- ------------------------------------------

-- SELECT COMMAND
select * from person;
select pid as personid,pname,page as "person age" from person; -- we can also use alias -- pass as string if contains space

-- CONDITIONAL BASED DATA WHERE CLAUSE AND OR NOT LIKE 
select * from person where (page!=12 and pgender="M");
select * from person where pgender='M' and pname like "s%";
select * from person where not pgender="M";
select * from person where (pgender='M' Or pname like "g%") and page>12;
select * from person where page is null;

-- IN AND NOT STATEMENT
select * from friend where fcity in ('jodhpur');
select * from friend where fcity not in ('jodhpur');

-- BETWEEN AND NOT BETWEEN
select * from person where page between 12 and 20; -- both begining and end values are included
select * from person;
select * from person where pdob between '2000-01-01' and '2007-10-01';
select * from person where page not between 10 and 20;
select * from person where pname between 'samyak' and 'z';

-- like operator
select * from person where pname like "k%" or pname like "s%";
select * from person where binary pname like 'S%' ; -- searches for only capital S 
select * from person where pname like "S%";         -- searches for both capital and small
select * from person where pname like "%am";
select * from person where pname like "%am%";
select * from person where page like 21;
select * from person where page=21;
select * from person where pname like "_ar%";


-- Regular expression
select * from person;
select * from person where pname regexp 'am'; -- contains am anywhere in like we use '%am%'
select * from person where pname regexp '^sa'; -- starting with sa
select * from person where pname regexp 'am$';	-- Ending with am
select * from person where pname regexp 'gu|am|ra|sh';	-- contains gu am ra sh anywhere in the string
select * from person where pname regexp 'gu|am$|^ra|^sh'; -- contains gu anywhere am at ending ra at starting starting with sh
select * from person where pname regexp '[mi]';  -- contains m or i anywhere in the string
select * from person where pname regexp 'a[mi]'; -- contains am or ai together
select * from person where pname regexp '^[sg]'; -- strating with s or g
select * from person where pname regexp '[km]$'; -- Ending with k or m
select * from person where pname regexp 's[a-z]';  -- contains s then a to z any character together


-- ORDER BY
select * from person order by pname DESC;
select * from person where pname regexp 'sa|sh' order by pname;

-- Distinct
select distinct page from person order by page;  -- selects only distinct records from table

-- isnull and isnotnull
select * from person where page is null;
select * from person where page is not null;

-- limit and offset 
select * from person limit 3;	-- gives only three records starting from first
select * from person limit 3,3; -- gives only three records starting from 4(4,5,6)
select * from person where page>12 order by page DESC limit 3 ;

-- AGGREGATE FUNCTIONS MIN MAX SUM COUNT AVG
select * from friend;
select max(fid) as "max fid",fname from friend;
select min(fid) as "min fid",fname from friend;

select * from person;
select avg(page) as "average age" from person;	-- for getting average of all ages
select sum(page) as "sum ages" from person;		-- for getting sum of all ages
select min(page) as "min age" from person;  -- for getting minimum age
select pname,page from person where page=(select min(page) from person);	-- for getting all names with minimum age @@@@@@important@@@@@@

select count(*) from person;  -- total 8 entries are there
select count(distinct page) from person; -- count of different ages present in our table 


-- update
select * from friend;
update friend set fname="mansvi" where fid=6;
update friend set fgender='M' where fid in(6,7);  -- we can update multiple rows
update friend set fgender='F' where fid=6;			-- we can also update single column
update friend set fname="ram",fcity="ayodhya" where fid=8; -- update multiple columns in the particular row;

-- commit and rollback
commit;
select * from  friend;
update friend set fgender='M' where fid in(1,2,3,4,5,6);
rollback;

-- delete 
commit;
delete from friend where fid=4;
select * from  friend;
delete from friend where fid=6 and fgender='M';
delete from friend;   							-- deletes the table data only skeleton remains
rollback;
commit;

-- alter

create table city(
cid int primary key auto_increment,
cname varchar(20) not null );

select * from city;
insert into city (cname)
values
('jaipur'),('jodhpur'),('raipur'),('dimapur'),('cuttack'),('mumbai'),('delhi'),('noida');

insert into city (cname)
 values
 ('chennai'),('kolkata');

select * from  person;
alter table person add city_id int;
alter table person add foreign key (city_id) references city(cid) ;

update person set city_id=person.pid;
update person set city_id=8 where pname='seema';


-- inner join
select * from person p inner join city c on p.city_id=c.cid;  -- chennai and kolkata will not be shown

-- left join
select * from person;
select * from city;
select * from person p left join city c on p.city_id=c.cid;
select * from person p left join city c on p.city_id=c.cid where pgender='M' order by pname;

-- right join
select * from person p right join city c on p.city_id=c.cid;

-- cross join can also be writtned as ,

select * from person p cross join city c on p.city_id=c.cid;  -- cross join can be replaced by ,
select * from person p,city c order by pname,cid ;

commit;

create table student(
sid int auto_increment primary key,
sname varchar(20),
cityid int,
courseid int);
insert into student(sname,cityid,courseid)
values('samyak',1,1),('harsh',2,2),('parag',2,2),('risabh',3,3),('gaman',4,1);
select * from student;

-- drop table course;

create table course(
co_id int auto_increment primary key,
coname varchar(20));

insert into course (coname)
values('BE'),('BTECH'),('MCA'),('BCA');

select * from course;

-- multiple joins joining more then one table  here in place of join we can use inner,outer,left,right joins
select sid,sname,coname from student s join course c on s.courseid=c.co_id;
select sid,sname,coname,cname from student s inner join course c on s.courseid=c.co_id inner join city on city.cid=s.cityid;


-- groupby and having
select * from person;
select page,count(page) as count from person where page>11 group by(page) having count>1 order by(page);

select * from student;
select coname,count(coname) from student s join course c on s.courseid=c.co_id group by coname; 


-- nested queries
select * from city;
select * from student where cityid=(select cid from city where cname="jodhpur");

-- exists and not exists command
select * from student where exists (select cid from city where cname in ("jodhpur","raipur"));
select * from student where not exists (select cid from city where cname in ("jodhpur","raipur"));


-- union and union all
-- in union common record will not be shown
select  fname,fgender from friend
union 
select pname,pgender from person;

-- in union all common record will also be shown
select  fname,fgender from friend
union all
select pname,pgender from person;

select * from student;
use learn;
commit;
alter table student add column percentage int;


-- if else and case statement
update student set percentage=(case 
when sid=1 then 92
when sid=2 then 78
when sid=3 then 63
when sid=4 then 36
when sid=5 then 25
end)
where sid in(1,2,3,4,5);

select sid,sname,percentage,if(percentage>=33,"PASS","FAIL") as result from student;

select sid,sname,percentage,case
when percentage<=100 and percentage>80 then "1st division"
when percentage<=80 and percentage>60 then "2nd division"
when percentage<=60 and percentage>40 then "3rd division"
when percentage<=40 then "fail"
end as Division
from student;

-- alter command
select * from student;
use learn;

alter table student add email varchar(255); 	-- adding new column to table
alter table student modify email int(255);		-- changing datatype of column of student table 
alter table student change email email_id varchar(255);  -- changing name of column in student table and datatype will also be changed
alter table student rename studentss;						-- renaming table student 
alter table student drop column email_id;				-- removing existing column from table

delete from student where sid=6;
insert into student (sname,cityid,courseid)
values('gyan',3,3);								-- here gyan sid is by default 7 due to auto increment error

alter table student auto_increment=6;				-- we can change the value of auto_increment by alter command also


-- table containing only auto increment table must contain only one auto_increment column which must be defined as key
create table incr(
aid int auto_increment primary key);

insert into incr values();		-- run this multiple times to add multiple values
select * from incr;
-- ----------------------------------

-- index command
select sname from student where sname like "s%";
create index myindex on student(sname);
show index from student;

-- drop and truncate command
truncate table incr;
drop table incr;

-- views
select * from student;
select sname,cname,coname from student s join city c on s.cityid=c.cid join course co on s.courseid=co.co_id;

create view myview as
select sname,cname from student s join city c on s.cityid=c.cid;


alter view myview as 														-- in place of alter view we can use create or replace view
select sname,cname,coname from student s join city c on s.cityid=c.cid join course co on s.courseid=co.co_id;

select * from myview;

rename table myfirstview to myview;
select * from myfirstview;


drop view myview;




-- arithematic functions
select pi();
select ceil(1.2),ceil(1.9);
select floor(1.2),floor(1.9);
select pow(2,3);
select sqrt(4);
select abs(1.2),abs(-1.3);
select sign(11),sign(0),sign(0.12);
select rand();
select ceil(rand()*100),floor(rand()*100);
select 2+ceil(rand()*3);		-- outputs value between 3 and 5 integral values only
select 2+(rand()*3);			-- outputs value between >2 and <=5

select round(123.1213);		-- rounded before decimal places if<5 then same
select round(123.92341);		-- rounded before decimal places if>5 then incremented;
select round(123.5221);				-- if 5 then always incremented;
select round(122.5123);



select * from student order by rand();		-- outputs data in random order


--  string functions
select upper(sname),sid from student;		-- upper can also be replaced with ucase 
select lower(sname),sid from student;		-- lower can also be replaced with lcase
select length(sname),sname from student; 	-- will return length of the string space character will be counted in bytes
select char_length(sname),sname from student;	-- will return length of character 

select sname,sid,concat(sname,sid) from student;	-- will concatenate the sname and sid columns
select sname,sid,concat(sname," ",sid) from student;		-- will concatenate the both strings
select sname,sid,concat_ws("-",sname,sid) from student;		-- in concat_ws we can specify the seperator 

-- these trim functions is not understood
select ltrim("samyakjain","am" );
select rtrim("   	samyak		jain		 	" );
select trim("   	samyak		jain		 	" );

select position("a" in "samyak");			-- first position of a will be returned
select position("at" in "samyak");			-- if at not found in string then 0 will be returned
select locate("am","samyak");
select locate("am","samyak",3);		-- offset can also be give from where t start search here search will start at 3 means m
select instr("samyak","a");					-- if a substring in string

    
-- date functions
select current_date();		-- date will be shown server
select curdate();			-- date will be shwon server
select sysdate();			-- both date and time of system will bw shown
select now();				-- both date and time of system
select date(now());			-- only returns date of string passed here now will be current date and time;
select month(now());		-- returns number of month 
select monthname(now());	-- returns name of month
select year(now());			-- return year of month
select day(now());			-- returns the day date  09-10-2022 returns 9
select dayofmonth(now());	-- which returns date
select dayname(now());		-- what is the dayname today sunday,monday....
select dayofweek(now());	-- which day of week sunday-1,monday-2,tuesday-3....etc
select dayofyear(now());	-- which day of year number
select week(now());			-- which week of year number
select weekday(now());		-- 
select yearweek(now());		-- which year and week number
select last_day(now());		-- what is the last date of this month 2022-10-31


select extract(month from now()); -- at the place of month we can extract year,day,weekday
-- ,week,date,time,hour,minute,second,microsecond etc

-- more advanced date functions
select adddate(now(),interval 1 month);	-- add a particular interval here in place of month we can use year,quarter,week,day,hour,minute,second,microsecond etc
select adddate(now(),interval 500 minute);	-- add interval of 500 minute
select adddate(now(),interval 12 hour);		-- add interval of 12 hours
-- same as adddate function we can use date_add() function 
select makedate(2022,03);		-- the date which we want to make will be passed here and it will return only first month
select subdate(now(),interval 11 hour);		-- to subtract the interval from date

select datediff(date(now()),"2001-04-20");		-- returns difference in dates as number of days
select to_days(now());							-- how many days till now from 0000-01-01

select date_format(now(),"%d-%m-%y");	-- returns the date in desired format
select date_format(now(),"%d-%M-%Y");	-- returns date in desired fromat
select date_format(now(),"%d-%M-%Y,%W");	-- week name will also be shown alonf=g with date
select date_format(now(),"%d-%M-%Y,%h:%i:%s:%f:%p");		-- date and time format also specified %i-min %f-microsec %p-am/pm


select str_to_date("20 april 2001","%d %M %y");		-- converts string date to mysql understoodable dates


-- time functions
select current_time();		-- returns current time
select curtime();			-- returns current time
select current_timestamp();	-- returns current  date and time;
select localtime();			-- returns local date and time
select localtimestamp();	-- returns date and time

select time(now());			-- returns time
select hour(now());
select minute(now());
select second(now());
select timediff(time(now()),"20:55:16");		-- returns diffenrce between two times 1st-last
select addtime(now(),"20:55:16.04");			-- returns time and date after adding time
select subtime(now(),"20:55:16.04");			-- subtract time

select maketime(10,20,10);			-- 10:20:10 makes the time
select timestamp("2019-2-11","20:01:16");		-- will make date and time combined in mysql format
select time_format("20:01:16","%h");			-- to show the time
select time_to_sec("20:01:16");			-- convert time to seconds
select sec_to_time("72076");			-- convert seconds to time


select fgender,count(fgender) from friend group by fgender ;

select quarter(now()); 		-- returns quarter umber is going on 1=jan-mar,2=apr-june,3=july-sept,4=oct-dec

-- enum datatype
create table shirts(
id int primary key not null,
size enum('small','large','xl'));

drop table shirts;
use learn;
select * from shirts;
alter table shirts change id  id int not null auto_increment ;
insert into shirts(size)
values
(1),(2),(1),(3);


-- variables
set @v1=7+1;					
set @v2=3;
set @'v2-v1'=@v2-@v1;
select @'v2-v1';  
select @myvar:=@v2-@v1;			-- if variable name used without set use := because = alone treated as assignment and will return1 if assigned successfully
select @myvar;
select @V1;  					-- variable names are not case sensitive





use wings;
select * from employee;	
select DATE_FORMAT(FROM_DAYS(DATEDIFF(now(),e_dob)), '%Y')+0 as age,e_name from employee;
    