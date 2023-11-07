SELECT *FROM [Pizz DB].[dbo].[pizza_sales]

--1.	Total Revenue

select sum(total_price) as Total_Revenue from pizza_sales

--2.	Average Order Value

select sum(total_price)/ count (distinct order_id) as Avg_Value from pizza_sales

--3.	Total Pizzas Sold

select sum(quantity) as Total_Pizza_Sold from pizza_sales

--4.	Total Orders

select count(distinct order_id) as Total_Orders from pizza_sales

--5.	Average Pizza Per Order

select cast(cast(sum(quantity)as decimal(10,2))/ cast(Count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as Avg_Pizzas_per_Order from pizza_sales

--Daily Trend for Total Orders:

select DATENAME (DW,order_date) as order_day, count (distinct order_id) as Total_orders
from pizza_sales group by DATENAME(DW, order_date)

--Monthly Trend for Total Orders:

select DATENAME(month, order_date) as Month_Name, count(distinct order_id) as Total_Orders
from pizza_sales group by DATENAME(month, order_date) 
order by Total_Orders desc

--Percentage of Sales by Pizza Category:

select pizza_category, sum(total_price) as Total_sales, sum (total_price) * 100 / 
(select sum(total_price) from pizza_sales where month(order_date)=1 )as PCT
from pizza_sales  
where month(order_date)=1  group by pizza_category

--Percentage of Sales by Pizza Size:

select pizza_size, sum(total_price) as Total_sales, cast (sum (total_price) * 100 / 
(select sum(total_price) from pizza_sales where DATEPART(quarter, order_date)=1) as decimal(10,2) )as PCT
from pizza_sales 
where DATEPART(quarter, order_date)=1
 group by pizza_size
 order by PCT desc

 --Top 5 Best Seller by Pizza Name

 select top 5 pizza_name, sum(total_price) as Total_revenue from pizza_sales
 group by pizza_name
 order by Total_revenue desc

 --Bottom 5 Worst Seller by Revenue

 select top 5 pizza_name, sum(total_price) as Total_revenue from pizza_sales
 group by pizza_name
 order by Total_revenue

 --Top 5 Best Seller by Pizza Quantity

 select top 5 pizza_name, sum(quantity) as Total_Quantity from pizza_sales
 group by pizza_name
 order by Total_Quantity desc

 --Bottom 5 Worst Seller by Quantity

 select top 5 pizza_name, sum(quantity) as Total_Quantity from pizza_sales
 group by pizza_name
 order by Total_Quantity

 --Top 5 Best Seller by Pizza Orders

 select top 5 pizza_name, count(distinct order_id) as Total_Orders from pizza_sales
 group by pizza_name
 order by Total_Orders desc

  --Bottom 5 Worst Seller by Orders

  select top 5 pizza_name, count(distinct order_id) as Total_Orders from pizza_sales
 group by pizza_name
 order by Total_Orders