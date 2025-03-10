create database stress_data;
use stress_data;

alter table stress
RENAME COLUMN ï»¿inter_dom TO inter_dom;

select depsev from stress;

-- DATA CLEANING --
show columns from stress;

SELECT * FROM stress
WHERE Internet_bi = '';

SELECT 
    SUM(CASE WHEN inter_dom = '' THEN 1 ELSE 0 END) AS `inter_dom_missing`,
    SUM(CASE WHEN `Region` = '' THEN 1 ELSE 0 END) AS `Region_missing`,
    SUM(CASE WHEN `Gender` = '' THEN 1 ELSE 0 END) AS `Gender_missing`,
    SUM(CASE WHEN `Academic` = '' THEN 1 ELSE 0 END) AS `Academic_missing`,
    SUM(CASE WHEN `Age` = '' THEN 1 ELSE 0 END) AS `Age_missing`,
    SUM(CASE WHEN `Age_cate` = '' THEN 1 ELSE 0 END) AS `Age_cate_missing`,
    SUM(CASE WHEN `Stay` = '' THEN 1 ELSE 0 END) AS `Stay_missing`,
    SUM(CASE WHEN `Stay_Cate` = '' THEN 1 ELSE 0 END) AS `Stay_Cate_missing`,
    SUM(CASE WHEN `Japanese` = '' THEN 1 ELSE 0 END) AS `Japanese_missing`,
    SUM(CASE WHEN `Japanese_cate` = '' THEN 1 ELSE 0 END) AS `Japanese_cate_missing`,
    SUM(CASE WHEN `English` = '' THEN 1 ELSE 0 END) AS `English_missing`,
    SUM(CASE WHEN `English_cate` = '' THEN 1 ELSE 0 END) AS `English_cate_missing`,
    SUM(CASE WHEN `Intimate` = '' THEN 1 ELSE 0 END) AS `Intimate_missing`,
    SUM(CASE WHEN `Religion` = '' THEN 1 ELSE 0 END) AS `Religion_missing`,
    SUM(CASE WHEN `Suicide` = '' THEN 1 ELSE 0 END) AS `Suicide_missing`,
    SUM(CASE WHEN `Dep` = '' THEN 1 ELSE 0 END) AS `Dep_missing`,
    SUM(CASE WHEN `DepType` = '' THEN 1 ELSE 0 END) AS `DepType_missing`,
    SUM(CASE WHEN `ToDep` = '' THEN 1 ELSE 0 END) AS `ToDep_missing`,
    SUM(CASE WHEN `DepSev` = '' THEN 1 ELSE 0 END) AS `DepSev_missing`,
    SUM(CASE WHEN `ToSC` = '' THEN 1 ELSE 0 END) AS `ToSC_missing`,
    SUM(CASE WHEN `APD` = '' THEN 1 ELSE 0 END) AS `APD_missing`,
    SUM(CASE WHEN `AHome` = '' THEN 1 ELSE 0 END) AS `AHome_missing`,
    SUM(CASE WHEN `APH` = '' THEN 1 ELSE 0 END) AS `APH_missing`,
    SUM(CASE WHEN `Afear` = '' THEN 1 ELSE 0 END) AS `Afear_missing`,
    SUM(CASE WHEN `ACS` = '' THEN 1 ELSE 0 END) AS `ACS_missing`,
    SUM(CASE WHEN `AGuilt` = '' THEN 1 ELSE 0 END) AS `AGuilt_missing`,
    SUM(CASE WHEN `AMiscell` = '' THEN 1 ELSE 0 END) AS `AMiscell_missing`,
    SUM(CASE WHEN `ToAS` = '' THEN 1 ELSE 0 END) AS `ToAS_missing`,
    SUM(CASE WHEN `Partner` = '' THEN 1 ELSE 0 END) AS `Partner_missing`,
    SUM(CASE WHEN `Friends` = '' THEN 1 ELSE 0 END) AS `Friends_missing`,
    SUM(CASE WHEN `Parents` = '' THEN 1 ELSE 0 END) AS `Parents_missing`,
    SUM(CASE WHEN `Relative` = '' THEN 1 ELSE 0 END) AS `Relative_missing`,
    SUM(CASE WHEN `Profess` = '' THEN 1 ELSE 0 END) AS `Profess_missing`,
    SUM(CASE WHEN `Phone` = '' THEN 1 ELSE 0 END) AS `Phone_missing`,
    SUM(CASE WHEN `Doctor` = '' THEN 1 ELSE 0 END) AS `Doctor_missing`,
    SUM(CASE WHEN `Reli` = '' THEN 1 ELSE 0 END) AS `Reli_missing`,
    SUM(CASE WHEN `Alone` = '' THEN 1 ELSE 0 END) AS `Alone_missing`,
    SUM(CASE WHEN `Others` = '' THEN 1 ELSE 0 END) AS `Others_missing`,
    SUM(CASE WHEN `Internet` = '' THEN 1 ELSE 0 END) AS `Internet_missing`,
    SUM(CASE WHEN `Partner_bi` = '' THEN 1 ELSE 0 END) AS `Partner_bi_missing`,
    SUM(CASE WHEN `Friends_bi` = '' THEN 1 ELSE 0 END) AS `Friends_bi_missing`,
    SUM(CASE WHEN `Parents_bi` = '' THEN 1 ELSE 0 END) AS `Parents_bi_missing`,
    SUM(CASE WHEN `Relative_bi` = '' THEN 1 ELSE 0 END) AS `Relative_bi_missing`,
    SUM(CASE WHEN `Professional_bi` = '' THEN 1 ELSE 0 END) AS `Professional_bi_missing`,
    SUM(CASE WHEN `Phone_bi` = '' THEN 1 ELSE 0 END) AS `Phone_bi_missing`,
    SUM(CASE WHEN `Doctor_bi` = '' THEN 1 ELSE 0 END) AS `Doctor_bi_missing`,
    SUM(CASE WHEN `religion_bi` = '' THEN 1 ELSE 0 END) AS `religion_bi_missing`,
    SUM(CASE WHEN `Alone_bi` = '' THEN 1 ELSE 0 END) AS `Alone_bi_missing`,
    SUM(CASE WHEN `Others_bi` = '' THEN 1 ELSE 0 END) AS `Others_bi_missing`,
    SUM(CASE WHEN `Internet_bi` = '' THEN 1 ELSE 0 END) AS `Internet_bi_missing`
FROM stress;

-- General Trends & Overview --
-- 1. What is the average depression severity across different academic years?


select academic, depsev, count(depsev) as counts from stress
group by depsev, academic;

-- 2 How does anxiety (APD) vary by gender?
select gender, count(apd) as levels from stress
group by gender;

-- 3.  What is the average loneliness level among students based on their living situation? 

select stay_cate, AVG(CASE WHEN Alone_bi = 'Yes' THEN 1 ELSE 0 END) AS avg_loneliness from stress
group by stay_cate
order by stay_cate;

-- 4.How does suicidal tendency (Suicide) vary across different age groups?

select age_cate, count(suicide) as con from stress
group by age_cate
order by age_cate;

-- 5.What is the relationship between English proficiency and depression severity?

select english_cate, count(depsev) as con from stress
group by english_cate;

-- 6. How does intimate relationship status affect anxiety levels?

select intimate, count(apd) as con from stress
group by intimate;

-- 7. What percentage of students seek professional help for mental health issues?

select academic, round((sum(case when professional_bi = "yes" then 1 end)/count(*))*100,2) as seek from stress
group by academic;

-- 8. How do students from different regions differ in their mental health indicators?
select region, count(case when suicide= 'yes' then 1 end) as sui, count(case when dep= 'yes' then 1 end) as dep, round(avg(apd),2) as anx from stress
group by region ;

-- 9. What is the most common source of emotional support among students?
select academic,
sum(case when partner_bi= "yes" then 1 end) as partner_supp, 
sum(case when Friends_bi= "yes" then 1 end) as friends_supp, 
sum(case when Parents_bi= "yes" then 1 end) as parents_supp, 
sum(case when Relative_bi= "yes" then 1 end) as relative_supp, 
sum(case when Professional_bi= "yes" then 1 end) as professional_supp, 
sum(case when Phone_bi= "yes" then 1 end) as phone_supp, 
sum(case when Doctor_bi= "yes" then 1 end) as doctor_supp, 
sum(case when religion_bi= "yes" then 1 end) as religion_supp, 
sum(case when Alone_bi= "yes" then 1 end) as alone_supp, 
sum(case when Others_bi= "yes" then 1 end) as others_supp, 
sum(case when Internet_bi= "yes" then 1 end) as internet_supp
from stress
group by academic;

-- 10. How does academic performance relate to depression and anxiety levels? 

select academic, depsev, avg(apd) as apd from stress
group by depsev
order by apd desc;