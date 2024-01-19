use my_guitar_shop;


-- 1. Write a SELECT statement that returns these columns:
-- The count of the number of orders in the Orders table
-- The sum of the tax_amount columns in the Orders table

SELECT 
count(order_id),
sum(tax_amount)
from orders;

-- 2. Write a SELECT statement that returns one row for each category that has products
-- with these columns:
-- The category_name column from the Categories table
-- The count of the products in the Products table
-- The list price of the most expensive product in the Products table
-- Sort the result set so the category with the most products appears first.

SELECT c.category_name, count(p.product_id), max(p.list_price)
from categories c 
join products p
on c.category_id = p.category_id
group by c.category_id
order by count(p.product_id) desc;

-- 3. Write a SELECT statement that returns one row for each customer that has orders
-- with these columns:
-- The email_address column from the Customers table
-- The sum of the item price in the Order_Items table multiplied by the
-- quantity in the Order_Items table
-- The sum of the discount amount column in the Order_Items table
-- multiplied by the quantity in the Order_Items table

select c.email_address, sum(o.item_price * o.quantity), sum(o.discount_amount * o.quantity)
from orders o1
join customers c
on o1.customer_id = c.customer_id
join order_items o
on o.order_id = o1.order_id
group by c.customer_id;

-- 4. Write a SELECT statement that returns one row for each customer that has orders
-- with these columns:
-- The email_address column from the Customers table
-- A count of the number of orders
-- The total amount for each order (Hint: First, subtract the discount
-- amount from the price. Then, multiply by the quantity.)
-- Return only those rows where the customer has more than 1 order.
-- Sort the result set in descending sequence by the sum of the line item amounts.

SELECT 
c.email_address, 
count(o.order_id) as No_of_Items, 
sum((o.item_price - o.discount_amount) * o.quantity) as Item_amount
from orders o1
join customers c
on o1.customer_id = c.customer_id
join order_items o
on o.order_id = o1.order_id
group by c.customer_id
having count(o.order_id)>1
order by Item_amount desc;

-- 5. Modify the solution to exercise 4 so it only counts and totals line items that have an
-- item_price value that’s greater than 400.

SELECT 
c.email_address, 
count(o.order_id) as No_of_Items, 
sum((o.item_price - o.discount_amount) * o.quantity) as Item_amount
from orders o1
join customers c
on o1.customer_id = c.customer_id
join order_items o
on o.order_id = o1.order_id
where o.item_price > 400
group by c.customer_id
having count(o.order_id) > 1
order by o.item_price desc; 


-- 6. Write a SELECT statement that answers this question: What is the total amount
-- ordered for each product? Return these columns:
-- The product_name column from the Products table
-- The total amount for each product in the Order_Items table (Hint: You
-- can calculate the total amount by subtracting the discount amount from
-- the item price and then multiplying it by the quantity)
-- Use the WITH ROLLUP operator to include a row that gives the grand total.
-- Note: Once you add the WITH ROLLUP operator, you may need to use MySQL
-- Workbench’s Execute SQL Script button instead of its Execute Current Statement
-- button to execute this statement.

SELECT
p.product_name,
sum((o.item_price - o.discount_amount) * o.quantity) as total_amount
from products p
join order_items o
on p.product_id = o.product_id
group by p.product_name
with rollup;


-- 7. Write a SELECT statement that answers this question: Which customers have
-- ordered more than one product? Return these columns:
-- The email_address column from the Customers table
-- The count of distinct products from the customer’s orders
-- Sort the result set in ascending sequence by the email_address column.


SELECT c.email_address, count(distinct o.product_id)
from orders o1
join customers c
on o1.customer_id = c.customer_id
join order_items o
on o.order_id = o1.order_id
group by c.email_address
having count(distinct o.product_id) > 1
order by c.email_address;


-- 8. Write a SELECT statement that answers this question: What is the total quantity
-- purchased for each product within each category? Return these columns:
-- The category_name column from the category table
-- The product_name column from the products table
-- The total quantity purchased for each product with orders in the Order_Items
-- table
-- Use the WITH ROLLUP operator to include rows that give a summary for each
-- category name as well as a row that gives the grand total.
-- Use the IF and GROUPING functions to replace null values in the category_name
-- and product_name columns with literal values if they’re for summary rows. 

SELECT 
if(grouping(c.category_name) = 1, "GRAND     TOTAL", c.category_name) AS 'Category_name',
if(grouping(p.product_name) = 1, "PRODUCT     QUANTITY     TOTAL", p.product_name) as 'Product_name',
sum(o.quantity)
FROM products p
join categories c
on p.category_id = c.category_id
join order_items o
on p.product_id = o.product_id
group by c.category_name, p.product_name
with rollup;


-- 9. Write a SELECT statement that uses an aggregate window function to get the total
-- amount of each order. Return these columns:
-- The order_id column from the Order_Items table
-- The total amount for each order item in the Order_Items table (Hint: You can
-- calculate the total amount by subtracting the discount amount from the item price
-- and then multiplying it by the quantity)
-- The total amount for each order
-- Sort the result set in ascending sequence by the order_id column.

SELECT o.order_id, 
sum((o.item_price - o.discount_amount) * o.quantity) OVER(PARTITION BY o.item_id) as Total_item_amount,
sum((o.item_price - o.discount_amount) * o.quantity) OVER(PARTITION BY o.order_id) as Total_order_amount
from order_items as o
order by o.order_id
;
-- 10. Modify the solution to exercise 9 so the column that contains the total amount for
-- each order contains a cumulative total by item amount.
-- Add another column to the SELECT statement that uses an aggregate window
-- function to get the average item amount for each order.
-- Modify the SELECT statement so it uses a named window for the two aggregate
-- functions. 

SELECT o.order_id, 
sum((o.item_price - o.discount_amount) * o.quantity) OVER(PARTITION BY o.item_id) as Total_amount,
sum((o.item_price - o.discount_amount) * o.quantity) OVER(by_order order by (o.item_price - o.discount_amount) * o.quantity) as Total_amount_cummulative,
round(avg((o.item_price - o.discount_amount) * o.quantity) OVER(by_order),2) as Average_amount
from order_items as o
WINDOW by_order as (PARTITION BY order_id)
order by o.order_id
;


-- 11. Write a SELECT statement that uses aggregate window functions to calculate the
-- order total for each customer and the order total for each customer by date. Return
-- these columns:
-- The customer_id column from the Orders table
-- The order_date column from the Orders table
-- The total amount for each order item in the Order_Items table
-- The sum of the order totals for each customer
-- The sum of the order totals for each customer by date (Hint: You can create a
-- peer group to get these values)

SELECT 
o1.customer_id, 
o1.order_date,
sum((o.item_price - o.discount_amount) * o.quantity) over(partition by o.item_id) as total_item_price,
sum((o.item_price - o.discount_amount) * o.quantity) over (customer) as Order_total,
sum((o.item_price - o.discount_amount) * o.quantity) over (customer order by o1.order_date RANGE unbounded preceding) as order_total_by_date
from orders o1
join order_items o 
on o.order_id = o1.order_id
window customer as (partition by o1.customer_id);








