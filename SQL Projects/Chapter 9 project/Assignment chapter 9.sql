use my_guitar_shop;

-- Q1
Select list_price,
discount_percent,
round(list_price*(1-discount_percent/100) , 2) as discount_amount
from products;

-- Q2
select order_date,
date_format(order_date, "%Y"),
date_format(order_date, "%b-%d-%Y"),
date_format(order_date, "%l:%m %p"),
date_format(order_date, "%m/%d/%y %H:%i")
from orders;

-- Q3
select card_number,
length(card_number),
right(card_number, 4),
if(length(card_number) = 16, concat('XXXX-XXXX-XXXX-',right(card_number, 4)), 
if(length(card_number) = 15, concat('XXXX-XXXXXX-X',right(card_number, 4)),Null))
as hidden_card_numbers
from orders;

-- Q4
Select order_id,
order_date,
date_add(order_date, interval 2 day) as approx_ship_date,
if (isnull(ship_date),'',ship_date) as ship_date,
datediff(ship_date, order_date) as days_to_ship
from Orders
where month(order_date) = 3 and year(order_date) = 2018;
    
-- Q5
Select email_address,
REGEXP_SUBSTR(email_address, '^[A-Z][a-z]+') as user_name,
REGEXP_SUBSTR(email_address, '[A-Z][a-z]+\.[A-Z][a-z]+$') as domain_name
from Administrators;

-- Q6
select p.product_name,
SUM(o.quantity) AS total_quantity,
RANK() over(ORDER BY SUM(o.quantity) desc) as 'rank',
DENSE_RANK() OVER (ORDER BY SUM(o.quantity) desc) as 'dense_rank'
from products p
join order_items o on p.product_id = o.product_id
group by p.product_name;

-- Q7
SELECT
c.category_name,
p.product_name,
SUM((o.item_price-o.discount_amount)*o.quantity) AS total_sales,
FIRST_VALUE(p.product_name) OVER (PARTITION BY c.category_id ORDER BY SUM((o.item_price-o.discount_amount)*o.quantity) DESC) AS highest_sales,
LAST_VALUE(p.product_name) OVER (PARTITION BY c.category_id ORDER BY SUM((o.item_price-o.discount_amount)*o.quantity) ASC) AS lowest_sales
from categories c
join products p on c.category_id = p.category_id
join  Order_Items o on p.product_id = o.product_id
group by c.category_name, p.product_name;











