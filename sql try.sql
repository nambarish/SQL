create database employee;
use employee;
create table employees (emp_id int, dept varchar(20), sal int);
insert into employees (emp_id, dept, sal)
values (1, 'IT', 20000);
insert into employees
values (2, 'IT', 22000);
insert into employees
values (3, 'HR', 25000);
insert into employees
values (4, 'IT', 21000);
insert into employees
values (5, 'HR', 35000);
select * from employees;

select dept, avg(sal) as salary from employees
group by dept;

select emp_id
from employees
where sal > (select avg(sal) from employees)
group by emp_id;

select emp_id, dept, sum(sal) from employees
group by dept;

select * from employees
where dept = "HR" or emp_id = 1;

select * from employees
where dept = "HR" and emp_id = 1;


