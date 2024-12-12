SELECT * FROM da_file1.`sales data`;
use da_file1;
SELECT 
    `Order ID`, 
    COUNT(`Order ID`) AS order_count
FROM 
    `sales data`
GROUP BY 
    `Order ID` 
order by `order_count` desc;

SELECT 
  * 
FROM 
  `sales data` 
WHERE 
  `myunknowncolumn` IS NULL 
  OR `order id` IS NULL 
  OR `product` IS NULL 
  OR `Quantity Ordered` IS NULL 
  OR `Price Each` IS NULL 
  OR `Order Date` IS NULL 
  OR `Purchase Address` IS NULL 
  OR `Month` IS NULL 
  OR `Sales` IS NULL 
  OR `City` IS NULL 
  OR `Hour` IS NULL;

-- General Sales Performance --
/*1. What is the total revenue generated over a specific period?*/

select distinct (year(`order date`)) as years, month(`order date`)as months, sum(sales) as revenue from `sales data`
group by months, years
order by months desc;

/*2. How many orders were placed during the analysis period?*/
select year(`order date`) as years, month(`order date`)as months, count(`order id`) as `order count` from `sales data`
group by months, years
order by months desc;

/*3. What is the average order value (AOV)?*/
select distinct (year(`order date`)) as years, month(`order date`)as months, avg(`Sales`) as `order value` from `sales data`
group by months, years
order by months desc;

/*4. What is the total number of unique customers?*/
select count(distinct(`purchase address`)) from `sales data`;


-- Product Performance --
/*1. What are the top-selling products by quantity?*/
select product, count(Product) as quantity from `sales data`
group by product
order by quantity desc limit 5 ;

/*2. Which products generate the most revenue?*/
select product, round(sum(sales),1) as revenue from `sales data`
group by Product
order by revenue desc limit 3;

/*3. Are there any products with consistently low sales?*/
select month(`order date`)as months, product, round(sum(sales),1) as revenue from `sales data`
group by months, product
order by revenue asc limit 10;

-- Customer Insights --
/*1. Who are the top customers by revenue contribution?*/
select `purchase address` as customer , sum(sales) as revenue from `sales data`
group by `purchase address`
order by revenue desc limit 10 ;

/* 2.Which customer location contribute most to revenue?*/
select city , sum(sales) as revenue from `sales data`
group by city
order by revenue desc limit 10 ;

/* 3.What are the peak sales hours during the day?*/
select `hour` , sum(sales) as revenue from `sales data`
group by `hour`
order by revenue desc ;

