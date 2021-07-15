-- Total Sales
select sum(sales) from orders

--Total Profit
select sum(profit) from orders

--Profit Ratio
select sum(profit)/sum(sales) "Gross profit margin" from orders

--Profit per Order
select sum(profit)/(select count(distinct order_id) from orders) "Profit per order" from orders

--Sales per Customer
select sum(sales)/(select count(distinct customer_id) from orders) "Sales per customer" from orders

--Avg. Discount
select avg(discount) from orders

--Monthly Sales by Segment
select sum(sales),segment, date_trunc('month',order_date) "month" from orders 
group by segment,month

--Monthly Sales by Product Category
select sum(sales),category, date_trunc('month',order_date) "month" from orders
group by category,month

--Sales by Product Category over time
select sum(sales),category from orders
group by category

--Sales and Profit by Customer
select sum(sales)/(select count(distinct customer_id) from orders) "sales per customer",sum(profit)/(select count(distinct customer_id) from orders) "profit per customer" from orders

--Sales per region
select sum(sales),region from orders 
group by region

--Returned orders
select count(distinct a.order_id) from orders a left join returns b on a.order_id = b.order_id
where b.returned is not null

--Returned profit
select sum(profit) from orders a left join returns b on a.order_id = b.order_id
where b.returned is not null

--Profitable orders
select count(distinct order_id) "Orders", 100.0 * count(distinct order_id)/(select count(distinct order_id) from orders)  "Profitable orders %" from orders
where profit >0
