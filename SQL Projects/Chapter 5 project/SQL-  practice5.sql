/*Write an INSERT statement that adds this row to the Categories table:
category_name: Brass
Code the INSERT statement so MySQL automatically generates the category_id
column.*/
use my_guitar_shop;
Insert into categories ( category_id,category_name)
values (default,"Brass");

/*Write an UPDATE statement that modifies the row you just added to the Categories
table. This statement should change the product_name column to “Woodwinds”, and
it should use the category_id column to identify the row.*/
UPDATE categories
SET category_name= "Woodwinds"
WHERE category_id= 5;

/*Write a DELETE statement that deletes the row you added to the Categories table in
exercise 1. This statement should use the category_id column to identify the row*/
DELETE FROM categories where category_id= 5;

/*Write an INSERT statement that adds this row to the Products table:
product_id: The next automatically generated ID
category_id: 4
product_code: dgx_640
product_name: Yamaha DGX 640 88-Key Digital Piano
description: Long description to come.
list_price: 799.99
discount_percent: 0
date_added: Today’s date/time.
Use a column list for this statement.*/
Insert into products (product_id, category_id, product_code,product_name,description,list_price,discount_percent,date_added)
values(default,4, "dgx_640","Yamaha DGX 640 88-Key Digital Piano","Long description to come.",799.99,0, now());

/*Write an UPDATE statement that modifies the product you added in exercise 4. This
statement should change the discount_percent column from 0% to 35%.*/
Update products
set discount_percent = 35.00
where category_id= 4;

/*Write a DELETE statement that deletes the Keyboards category. When you execute
this statement, it will produce an error since the category has related rows in the
Products table. To fix that, precede the DELETE statement with another DELETE
statement that deletes all products in this category. (Remember that to code two or
more statements in a script, you must end each statement with a semicolon.) */
DELETE FROM Products where category_id= 4;
DELETE FROM categories where category_id= 4;

/* Write an INSERT statement that adds this row to the Customers table:
email_address: rick@raven.com
password: (empty string)
first_name: Rick
last_name: Raven
Use a column list for this statement.*/
Insert into Customers (email_address, password,first_name, last_name)
Values("rick@raven.com","", "Rick", "Raven");

/*Write an UPDATE statement that modifies the Customers table. Change the
password column to “secret” for the customer with an email address of
rick@raven.com.*/
UPDATE customers
SET password = "secret"
WHERE customer_id = 9;

/*Write an UPDATE statement that modifies the Customers table. Change the
password column to “reset” for every customer in the table. If you get an error due to
safe-update mode, you can add a LIMIT clause to update the first 100 rows of the
table. (This should update all rows in the table.)*/
Update customers
SET password = "reset"
limit 100;

/*Open the script named create_my_guitar_shop.sql that’s in the mgs_ex_starts
directory. Then, run this script. That should restore the data that’s in the database.*/









