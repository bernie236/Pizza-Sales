/*Added Foreign key that ties the details in each order to the order itself*/
ALTER TABLE dbo.order_details
ADD CONSTRAINT FK_Order_ID
FOREIGN KEY (order_id)
REFERENCES dbo.orders(order_id);
/* Added Foreign key that ties the pizza ordered to its details, like size and price*/
ALTER TABLE dbo.order_details
ADD CONSTRAINT FK_Pizza_ID
FOREIGN KEY (pizza_id)
REFERENCES dbo.pizzas(pizza_id);
/* Added Foreign key that ties each pizza to its broader pizza type*/
ALTER TABLE dbo.pizzas
ADD CONSTRAINT FK_Pizza_Type_ID
FOREIGN KEY (pizza_type_id)
REFERENCES dbo.pizza_types(pizza_type_id);

/* Start query for anlaysis here */
/* Query gives customers per day for every day of the year. */
SELECT
date,
COUNT(DISTINCT order_id) AS customers
FROM dbo.orders
GROUP BY date
ORDER BY date;

/* How many customers do we have each day? 59-60 customers per day*/
SELECT
AVG(customers) AS avg_customers_per_day
FROM (SELECT
date,
COUNT(DISTINCT order_id) AS customers
FROM dbo.orders
GROUP BY date) AS avg_customers_table

/* Are there any peak hours? Peak hours are from 12pm-2pm and 5pm-8pm.*/
SELECT
DATEPART(hh,time) AS hour_time,
COUNT(order_id) AS orders
FROM dbo.orders
GROUP BY DATEPART(hh,time)
ORDER BY DATEPART(hh,time);

/* How many pizzas are typically in an order? 2 pizzas per order.*/
SELECT 
AVG(number_of_pizzas) AS avg_pizzas_per_order
FROM (SELECT
order_id AS customers,
SUM(quantity) AS number_of_pizzas
FROM dbo.order_details
GROUP BY order_id) AS avg_pizzas_per_order_table;

/* Do we have any bestsellers? Classic deluxe, bbq chicken, hawaiian, pepperoni, thai chicken, and california chicken.*/
SELECT
p.pizza_type_id,
SUM(od.quantity) AS pizzas_sold
FROM dbo.order_details AS od
JOIN dbo.pizzas AS p ON od.pizza_id=p.pizza_id
GROUP BY pizza_type_id
ORDER BY SUM(quantity) desc
OFFSET 0 ROWS FETCH FIRST 10 ROWS ONLY;

/* Query shows pizza quantity sold for each type and revenue per pizza type. (Query used at the end again to answer last business question.)*/
SELECT
od.pizza_id,
SUM(od.quantity) AS pizzas,
p.price,
(SUM(od.quantity) * p.price) AS revenue
FROM dbo.order_details AS od
JOIN dbo.pizzas AS p ON od.pizza_id=p.pizza_id
GROUP BY od.pizza_id, p.price
ORDER BY revenue desc;

/* How much money did we make this year? $817,860.05*/
SELECT
SUM(revenue) AS total_revenue
FROM (SELECT
od.pizza_id,
(SUM(od.quantity) * p.price) AS revenue
FROM dbo.order_details AS od
JOIN dbo.pizzas AS p ON od.pizza_id=p.pizza_id
GROUP BY od.pizza_id, p.price) AS revenue_table;

/* Query shows the amount of orders per month. Similar amount of orders each month. */
SELECT
DATEPART(mm,o.date) AS monthly_order_count,
COUNT(od.order_details_id) AS orders
FROM dbo.orders AS o
JOIN dbo.order_details AS od ON o.order_id=od.order_id
GROUP BY DATEPART(mm,o.date)
ORDER BY DATEPART(mm,o.date);


/* Can we identify any seasonality in the sales? Doesn't appear to be seasonality in sales. Slight uptick in July which is the month with the highest revenue.*/
SELECT 
monthly_order_count,
SUM(revenue) AS monthly_revenue
FROM (SELECT
DATEPART(mm,date) AS monthly_order_count,
COUNT(o.order_id) AS orders,
od.pizza_id,
(SUM(od.quantity) * p.price) AS revenue
FROM dbo.orders AS o
JOIN dbo.order_details AS od ON o.order_id=od.order_id
JOIN dbo.pizzas AS p ON od.pizza_id=p.pizza_id
GROUP BY DATEPART(mm,date), p.price, od.pizza_id) AS monthly_revenue_table
GROUP BY monthly_order_count
ORDER BY monthly_order_count;

/* Are there any pizzas we should take off the menu, or any promotions we could leverage? Brie_carre was the worst selling pizza and only sold 480 pies compared to second worst green_gardent which sold 987 pies.*/
SELECT
pizza_type_id,
SUM(pizzas) AS total_pizzas_sold,
SUM(revenue) AS total_revenue
FROM (SELECT
pt.pizza_type_id,
SUM(od.quantity) AS pizzas,
(SUM(od.quantity) * p.price) AS revenue
FROM dbo.order_details AS od
JOIN dbo.pizzas AS p ON od.pizza_id=p.pizza_id
JOIN dbo.pizza_types AS pt ON p.pizza_type_id=pt.pizza_type_id
GROUP BY pt.pizza_type_id, p.price) AS revenue_per_pizza_type
WHERE pizza_type_id=pizza_type_id
GROUP BY pizza_type_id
ORDER BY total_revenue desc; 
