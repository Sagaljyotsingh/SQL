-- Q1:
Create or replace view billview as
select c.customer_id, 
line1 as bill_line1, 
line2 as bill_line2, 
city as bill_city, 
state as bill_state, 
zip_code as bill_zip
from 
customers c 
join addresses a
on c.billing_address_id = a.address_id;
Create or replace view shipview as
select 
c.customer_id, 
line1 as ship_line1, 
line2 as ship_line2, 
city as ship_city, 
state as ship_state, 
zip_code as ship_zip
from 
customers c 
join addresses a
on c.shipping_address_id = a.address_id;
Create or replace view customer_addresses
as Select 
c.customer_id,
c.first_name,
c.last_name,
c.email_address, 
b.bill_line1, 
b.bill_line2, 
b.bill_city, 
b.bill_state, 
b.bill_zip,
s.ship_line1, 
s.ship_line2, 
s.ship_city, 
s.ship_state, 
s.ship_zip
from customers c
join 
billview b
on b.customer_id = c.customer_id
join
shipview s
on s.customer_id = c.customer_id;
select * from customer_addresses;


-- Q2:
Select customer_id, 
last_name,
first_name,
bill_line1
from customer_addresses
order by last_name, first_name;

-- Q3:
Update customer_addresses
set ship_line1 = "1990 Westwood Blvd."
where customer_id = 8;

-- Q4:
Create or replace view order_item_products as
Select o.order_id,
order_date,
tax_amount,
ship_date,
product_name,
item_price,
discount_amount,
item_price - discount_amount as final_price,
quantity,
(item_price - discount_amount)* quantity as item_total
from
orders o1
join order_items o
on o.order_id = o1.order_id
join products p
on p.product_id = o.product_id;
select * from order_item_products;

-- Q5:
Create or replace view product_summary as
select distinct product_name,
count(product_name) as order_count,
sum(item_total) as order_total
from order_item_products
group by product_name;
select * from product_summary;

-- Q6:
Select product_name,
order_total 
From product_summary
order by order_total desc
limit 5;
