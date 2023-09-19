# Pizza-Sales
## About the Project
A year's worth of sales from a fictitious pizza place, including the date and time of each order and the pizzas served, with additional details on the type, size, quantity, price, and ingredients.

## Questions for the Analysis
1. How many customers do we have each day? Are there any peak hours?
2. How many pizzas are typically in an order? Do we have any bestsellers?
3. How much money did we make this year? Can we identify any seasonality in the sales?
4. Are there any pizzas we should take off the menu, or any promotions we could leverage?

## Key Insights from the Dataset
1. On average, we have about 60 customers a day.The peak business hours are between the lunch rush and dinner rush which are between 12-2pm and 5-7pm, respectively.
2. Customers order, on average, 2.32 whole pizzas when they visit our pizza place. Our best-selling pizzas are the Thai Chicken pizza($43,434 yearly revenue), the Barbecue Chicken Pizza($42,768 yearly revenue), and the California Chicken Pizza ($41,410 yearly revenue).
3. Our revenue for the entire year was $817,860. Overall, there doesn’t appear to be a significant difference in monthly revenue indicating seasonality in sales. However, there is a slight uptick in sales in the spring month of May and in the summer month of July. In contrast, sales slow down a little in the autumn.
4. The Brie Carre Pizza had the lowest total revenue for the year at $11,589 and sold 490 pizzas. The second lowest selling pizza by revenue was The Green Garden Pizza which sold 997 pizzas and generated $13,956 in revenue for the year. This difference in revenue and quantity sold could be a result of the Brie Carre Pizza only being available in one size, small, and is the second most expensive item on the menu. The Brie Carre Pizza should be taken off the menu because it has the lowest quantity sold by a large margin and the lowest revenue generation of all the pizzas.
		
## Recommendations
1. Leverage promotions during slow seasons like autumn by offering bundle deals such as buy one, get one free or at a discount. Another promotion to leverage during these slow seasons could be to offer exclusive discounts through email or social media.
2. Provide early-bird or late-night deals on pizzas to drive traffic during non-peak hours (before 12pm, after 9pm).
3. Leverage deals on lower revenue generating pizzas. For example, buy one pizza of your choice, and receive half off on an additional, select pizza.

## Tools Used
1. Used ALTER on tables to ADD CONSTRAINT of FOREIGN KEYS
2. Aggregate functions: SUM, COUNT, AVG were applied to calculate quantity of orders and revenue
3. Subqueries and JOINS utilized to combine tables to determine best-selling pizzas by yearly revenue, quantity sold, and monthly revenue
4. GROUP BY and ORDER BY were used to sort and organize results of queries

### Links
*  [Tableau Dashboard](https://public.tableau.com/views/PizzaSales_16940433977440/End-Of-YearPizzaSales?:language=en-US&:display_count=n&:origin=viz_share_link)
*  [Article]()

### Files 
* [query.sql](https://github.com/bernie236/Pizza-Sales/blob/main/query.sql) is the SQL code for the queries that I used for my analysis.
