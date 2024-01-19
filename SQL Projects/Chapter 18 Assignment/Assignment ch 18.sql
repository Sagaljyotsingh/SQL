
-- Q2:
CREATE USER 'group2'@'%' IDENTIFIED BY 'group2123';

GRANT SELECT, INSERT, UPDATE, DELETE ON my_guitar_shop.customers TO 'group2'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON my_guitar_shop.addresses TO 'group2'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON my_guitar_shop.orders TO 'group2'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON my_guitar_shop.order_items TO 'group2'@'%';
GRANT SELECT ON my_guitar_shop.products TO 'group2'@'%';
GRANT SELECT ON my_guitar_shop.categories TO 'group2'@'%';
REVOKE GRANT OPTION ON my_guitar_shop.* FROM 'group2'@'%';

-- drop user 'group2'@'%';
-- Q3
SHOW GRANTS for 'group2';

-- Q4:
REVOKE DELETE ON my_guitar_shop.orders FROM 'group2'@'%';
REVOKE DELETE ON my_guitar_shop.order_items FROM 'group2'@'%';
-- Q5:
SHOW GRANTS for 'group2';

-- Q6:
ALTER USER IF EXISTS 'group2' PASSWORD EXPIRE;








