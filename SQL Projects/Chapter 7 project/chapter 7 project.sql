-- Q1
select distinct category_name
from categories
where category_id in (
select category_id
from products)
order by category_name;

-- Q2
select product_name, list_price
from products
where list_price > 
( select avg(list_price)
from products
)
group by product_name, list_price
order by list_price desc;

-- Q3
select category_name
from categories c
where not exists
(select category_id
from products p
where p.category_id = c.category_id
)
group by category_name;

-- Q4

SELECT email_address, 
max(order_total) as largest_order
From 
(
select c.email_address as email_address, 
o.order_id, 
sum((o.item_price - o.discount_amount) * o.quantity) as order_total
from orders o1
join customers c
on c.customer_id = o1.customer_id
join order_items o
on o.order_id = o1.order_id
group by c.email_address, o.order_id
) a
group by email_address
order by largest_order desc;

-- Q5
select product_name, t.discount_percent
from
(Select discount_percent
from products
group by discount_percent
having count(*) = 1
) as t
join products p
on t.discount_percent = p.discount_percent
order by product_name;


-- Q6
SELECT
  c.email_address,
  o.order_id,
  (SELECT MIN(order_date)
   FROM orders
   WHERE customer_id = c.customer_id) AS order_date
FROM
  customers c
JOIN
  orders o ON o.customer_id = c.customer_id
ORDER BY
  order_date, o.order_id;
  
  