SELECT * FROM creditcard.`credit card transactions` as cct;

/* 1- query for top 5 cities based of top spend and their percentage contribution*/ 

with cte1 as
(select  City, sum(Amount) as totalspend from creditcard.`credit card transactions` as cct
group by city
order by totalspend desc)
, cte2 as
( select sum(Amount) as total from creditcard.`credit card transactions` as cct)
select c1.city, c1.totalspend,round(c1.totalspend/c2.total*100,2) as percent
from cte1 as c1
join cte2 as c2 on 1=1;

/* 2- query for highest spend month and amount spent in that monthfor each card type */

select EXTRACT(MONTH FROM `Date`) as tm, (`Card Type`) as ct, sum(Amount) as totalspend from creditcard.`credit card transactions` as cct
group by ct;

/* 3 - print trans details for each card when cumulative spend is over 1000000 */

with xtel as 
( select *, sum(amount) over (partition by `Card Type` order by `Date`) as cumulativesum from creditcard.`credit card transactions` as cct)
, xtel1 as
( select * , dense_rank() over (partition by `Card Type` order by cumulativesum) as dsnk from xtel
where cumulativesum >= 1000000)
select * from xtel1 where dsnk = 1;

/* lowest persent spend from gold card */

with ct1 as
(select * , sum(Amount) as ts from  creditcard.`credit card transactions` as cct
where `Card Type` = 'Gold'
group by city)
,ct2 as 
(select *, sum(Amount) as ts1 from creditcard.`credit card transactions` as cct)
select c1.City , c1.`Card Type`, round(c1.ts/c2.ts1 *100 ,2) as percent from ct1 as c1
join ct2 as c2 on c1.City=c2.City ;

/* 5 - query for highest and lowest expence rate bases on city */

/*with tel1 as
(select City, `Exp Type`, sum(amount) as ts from creditcard.`credit card transactions` as cct
group by city, `Exp Type`)
,tel2 as
(select City,
max(ts) as highestexp,
min(ts) as lowestexp from tel1
group by City)
select t1.City, t1.`Exp Type`, t1.ts, t2.highestexp, t2.lowestexp from tel1 as t1
join tel2 as t2 on t1.City = t2.City
group by t1.City; */

with tel1 as
(select City, `Exp Type`, sum(amount) as ts from creditcard.`credit card transactions` as cct
group by city, `Exp Type`)
,tel2 as
(select City,
max(ts) as highestexp,
min(ts) as lowestexp from tel1
group by City)
select t1.City,
max(case when ts=highestexp then `Exp Type` end) as highespend,
min(case when ts=lowestexp then `Exp Type` end) as lowspend
from tel1 as t1
join tel2 as t2 on t1.City = t2. City
group by t1.City;