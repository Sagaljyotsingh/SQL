/*Write a SELECT statement that joins the Categories table to the Products table and
returns these columns: category_name, product_name, list_price.
Sort the result set by the category_name column and then by the product_name
column in ascending sequence.
 */
use my_guitar_shop;
select category_name, product_name, list_price 
from categories 
join  products
on categories.category_id = products.category_id
order by category_name and product_name;
/*Write a SELECT statement that joins the Customers table to the Addresses table and
returns these columns: first_name, last_name, line1, city, state, zip_code.
Return one row for each address for the customer with an email address of
allan.sherwood@yahoo.com. */
select customers.first_name ,last_name, customers.customer_id ,line1 ,city ,state,zip_code,email_address
from customers inner join addresses 
on addresses.customer_id = customers.customer_id
where email_address ="allan.sherwood@yahoo.com";
/*Write a SELECT statement that joins the Customers table to the Addresses table and
returns these columns: first_name, last_name, line1, city, state, zip_code.
Return one row for each customer, but only return addresses that are the shipping
address for a customer. */
Select customers.first_name, last_name,line1,city,state,zip_code,customers.shipping_address_id
from customers inner join addresses
on addresses.customer_id = customers.customer_id;

/* Write a SELECT statement that joins the Customers, Orders, Order_Items, and
Products tables. This statement should return these columns: last_name, first_name,
order_date, product_name, item_price, discount_amount, and quantity.
Use aliases for the tables.
Sort the final result set by the last_name, order_date, and product_name columns.*/
Select c.last_name, c.first_name, o.order_date, p.product_name, oi.item_price, oi.discount_amount, oi.quantity
from order_items oi
inner join orders o
on o.order_id = oi.order_id
inner join customers c
on c.customer_id = o.customer_id 
join products p 
on p.product_id = oi.product_id
order by last_name, order_date, product_name;
/*Write a SELECT statement that returns the product_name and list_price columns
from the Products table.
Return one row for each product that has the same list price as another product.
Hint: Use a self-join to check that the product_id columns aren’t equal but the
list_price columns are equal.
Sort the result set by the product_name column.*/
select p.product_name, p.list_price 
from products p
join products p2
on p.list_price = p2.list_price and p.product_id <> p2.product_id;
/*Write a SELECT statement that returns these two columns:
category_name The category_name column from the Categories
table
product_id The product_id column from the Products table
Return one row for each category that has never been used. Hint: Use an outer join
and only return rows where the product_id column contains a null value.*/
select c.category_id, c.category_name, p.product_id
from categories c 
left join products p
on p.product_id = null;
/*Use the UNION operator to generate a result set consisting of three columns from the
Orders table:
ship_status A calculated column that contains a value of
SHIPPED or NOT SHIPPED
order_id The order_id column
order_date The order_date column
If the order has a value in the ship_date column, the ship_status column should
contain a value of SHIPPED. Otherwise, it should contain a value of NOT SHIPPED.
Sort the final result set by the order_date column.*/

select 'SHIPPED' as ship_status, order_id, order_date
from orders
where ship_date is not null
UNION
select 'NOT SHIPPED' as ship_status, order_id, order_date
from orders
where ship_date is null
order by order_date;



