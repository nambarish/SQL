-- Question set 1 - easy --

select * from employee;

-- 1. who is the senior most employee based on job title --

select concat(first_name,' ',last_name) as name, title from employee
order by levels desc
limit 1;

-- 2. Which countries have the most Invoices? -- 
select * from invoice_line;
select * from invoice;
select * from track;

select billing_country, count(invoice_id) as total from invoice
group by billing_country;

-- 3. What are top 3 values of total invoice? --
select billing_country, count(invoice_id) as total, round(sum(total),2) as price from invoice
group by billing_country
order by price desc
limit 3;

-- 4. Which city has the best customers? We would like to throw a promotional Music 
-- Festival in the city we made the most money. Write a query that returns one city that
-- has the highest sum of invoice totals. Return both the city name & sum of all invoice
-- totals 

select count(distinct(country)) from customer;

select * from customer;
select * from genre;

select customer_id, count(customer_id), invoice_id from invoice
group by customer_id;

-- join customer and invoice --

select c. city , round (sum(i.total),2) as price from customer as c 
join invoice as i on c.customer_id = i.customer_id
group by city
order by price desc
limit 1;

select concat(first_name,' ',last_name) as name , round (sum(i.total),2) as price from customer as c 
join invoice as i on c.customer_id = i.customer_id
group by city
order by price desc
limit 1;


-- Question Set 2 – Moderate --

select * from customer;
select * from genre;
select * from track;
select  * from artist;
-- 1. Write query to return the email, first name, last name, & Genre of all Rock Music listeners. Return your list ordered alphabetically by email starting with A  --

select c.email, c.first_name, c.last_name, g.name from customer as c
join invoice as i on c.customer_id=i.customer_id
join invoice_line as il on i.invoice_id = il.invoice_id
join track as t on il.track_id=t.track_id
join genre as g on t.genre_id = t.genre_id
where g.name = 'Rock'
group by email
order by email;

-- 2. Let's invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total track count of the top 10 rock bands --

select ar.name, count(t.genre_id) as counts from artist as ar
join album as a on ar.artist_id  = a.artist_id
join track as t on a.album_id = t.album_id
join genre as g on t.genre_id = t.genre_id
where g.name = "Rock"
group by ar.name
order by counts desc
limit 10;


-- 3. Return all the track names that have a song length longer than the average song length. 
-- Return the Name and Milliseconds for each track. Order by the song length with the 
-- longest songs listed first.

(select avg(milliseconds) from track);

 select name, milliseconds, (select avg(milliseconds) from track)as svgn from track
 where milliseconds > (select avg(milliseconds) from track)
 group by name
 order by milliseconds;
 
 -- Question Set 3 – ADVANCE --

-- 1. Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent.

select * from artist;
select * from track;
select * from customer;
select * from invoice;

select concat(first_name, ' ', last_name) as customer_name from customer;


SELECT 
    concat(first_name, ' ', last_name) as customer_name,
    ar.Name,
    SUM(il.Unit_Price * il.Quantity) AS TotalSpent
FROM Customer c
JOIN Invoice i ON c.Customer_ID = i.Customer_ID
JOIN Invoice_Line il ON i.Invoice_ID = il.Invoice_ID
JOIN Track t ON il.Track_ID = t.Track_ID
JOIN Album al ON t.Album_ID = al.Album_ID
JOIN Artist ar ON al.Artist_ID = ar.Artist_ID
GROUP BY Customer_Name, ar.Name
ORDER BY Customer_Name, TotalSpent DESC;

-- 2. We want to find out the most popular music Genre for each country. We determine the 
-- most popular genre as the genre with the highest amount of purchases. Write a query 
-- that returns each country along with the top Genre. For countries where the maximum 
-- number of purchases is shared return all Genres 

select c.country, g.name, round(sum(i.total),2) as total
FROM Customer c
JOIN Invoice i ON c.Customer_ID = i.Customer_ID
JOIN Invoice_Line il ON i.Invoice_ID = il.Invoice_ID
JOIN Track t ON il.Track_ID = t.Track_ID
JOIN genre g on t.genre_id = g.genre_id
group by country, name
order by country, total desc;

-- 3. Write a query that determines the customer that has spent the most on music for each 
-- country. Write a query that returns the country along with the top customer and how 
-- much they spent. For countries where the top amount spent is shared, provide all 
-- customers who spent this amount.

select c.country, concat(first_name, ' ', last_name) as customer_name,  round(SUM(il.Unit_Price * il.Quantity),2) AS TotalSpent
FROM Customer c
JOIN Invoice i ON c.Customer_ID = i.Customer_ID
JOIN Invoice_Line il ON i.Invoice_ID = il.Invoice_ID
JOIN Track t ON il.Track_ID = t.Track_ID
JOIN genre g on t.genre_id = g.genre_id
group by country, customer_name
order by country, totalspent desc;