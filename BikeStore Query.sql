USE BikeStores

-- Get the Revenue, total units per order and the customer details for each order.

SELECT so.order_id AS "Order ID"
		, sc.first_name + ' ' + sc.last_name AS "Customers Full Name"
		, sc.city AS "City"
		, sc.state AS "State"
		, so.order_date AS "Order Date"
		, pp.product_name AS "Product Name"
		, pc.category_name AS "Category Name"
		, ss.store_name AS "Store Name"
		, pb.brand_name AS "Brand Name"
		, CONCAT(sst.first_name, ' ', sst.last_name) AS "Sales Rep Name"
		, SUM(soi.quantity) AS "Total Units"
		, SUM(soi.quantity * soi.list_price) AS "Revenue"
		
FROM sales.orders AS so

-- JOIN several tables in order to retrieve the data needed for analysis

LEFT JOIN sales.customers AS sc
ON so.customer_id = sc.customer_id
LEFT JOIN sales.order_items AS soi
ON soi.order_id = so.order_id
INNER JOIN production.products AS pp
ON pp.product_id = soi.product_id
INNER JOIN production.categories pc
ON pc.category_id = pp.category_id
INNER JOIN sales.stores ss
ON ss.store_id = so.store_id
JOIN sales.staffs sst
ON sst.staff_id = so.staff_id
JOIN production.brands pb
ON pb.brand_id = pp.brand_id

-- Use Group By on multiple columns as we have and aggregate in the SELECT statement

GROUP BY so.order_id
		, sc.first_name + ' ' + sc.last_name
		, sc.city
		, sc.state
		, so.order_date
		, pp.product_name
		, pc.category_name
		, ss.store_name
		, CONCAT(sst.first_name, ' ', sst.last_name)
		, pb.brand_name

-- Connect Database to Excel for automatic refresh of data.

-- Questions Answered
-- Total revenue per year and per month.
-- Total revenue per customer and per sales representative.
-- Total revenue per state and per store.
-- Total revenue per brand and per product category
-- Top 10 customers 
