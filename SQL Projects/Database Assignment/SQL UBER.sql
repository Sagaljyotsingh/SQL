-- JOINS QUESTION: Write a select statement that returns these columns:
-- Customer_name, prefered_restaurant_name, prefered_restaurant_region_name.
Select if(p.last_name is not null,(concat(p.first_name," ",p.last_name)),p.first_name) as full_name, 
r.restaurant_name as preferred_restaurant, 
reg.region_name as preferred_restaurant_region
from persons p
join customers c
on c.customer_id = p.person_id
join restaurants r
on r.restaurant_id = c.preferred_restaurant_id
join regions reg
on reg.region_id = r.region_id;


-- Question of UNION
-- Use customers and orders details using full outer join.
Select if(p.last_name is not null,(concat(p.first_name," ",p.last_name)),p.first_name) as full_name,
age,
email,
home_address,
order_date,
order_time
from persons p
inner join customers c
on p.person_id = c.person_id
LEFT outer join orders o
on o.customer_id = c.person_id

UNION

Select if(p.last_name is not null,(concat(p.first_name," ",p.last_name)),p.first_name) as full_name,
age,
email,
home_address,
order_date,
order_time
from persons p
inner join customers c
on p.person_id = c.person_id
RIGHT outer join orders o
on o.customer_id = c.person_id
;
 
-- QUESTION of SUM, MIN,MAX, COUNT, AVG
-- Tell the (total, average, minimum, and maximum) amount paid for each order in order_items table:

Select oi.order_id, 
SUM((oi.item_price-oi.discount_amount)*oi.quantity) as Total_Amount, 
MIN((oi.item_price-oi.discount_amount)*oi.quantity) as Minimum_price_Amount,
MAX((oi.item_price-oi.discount_amount)*oi.quantity) as Maximum_price_Amount,
AVG((oi.item_price-oi.discount_amount)*oi.quantity) as Average_price_Amount
from order_items oi
group by oi.order_id;

-- Question of Functions:
-- Use the ROUND function to round the values from previous query to 3 decimal places.

Select oi.order_id, 
Round(SUM((oi.item_price-oi.discount_amount)*oi.quantity),3) as Total_Amount, 
Round(MIN((oi.item_price-oi.discount_amount)*oi.quantity),3) as Minimum_price_Amount,
Round(MAX((oi.item_price-oi.discount_amount)*oi.quantity),3) as Maximum_price_Amount,
Round(AVG((oi.item_price-oi.discount_amount)*oi.quantity),3) as Average_price_Amount
from order_items oi
group by oi.order_id;


-- Question with subqueries:
-- Find details of drivers like: Name, age, license number, vehicle number, vehicle type and experience using Subqueries.
Select 
*
From 
(
Select if(p.last_name is not null,(concat(p.first_name," ",p.last_name)),p.first_name) as full_name,
p.age as age,
d.vehicle_number as vehicle_number,
d.vehicle_type as vehicle_type,
d.driving_license_number as license_number,
d.years_of_service as years_of_experience
From persons p
join drivers d
on p.person_id = d.person_id
) t;


Select 
if(p.last_name is not null,(concat(t.first_name," ",t.last_name)),t.first_name) as full_name,
t.age as age,
t.vehicle_number as vehicle_number,
t.vehicle_type as vehicle_type,
t.driving_license_number as license_number,
t.years_of_service as years_of_experience
From 
(
Select * except()
From persons p
join drivers d
on p.person_id = d.person_id
) t
