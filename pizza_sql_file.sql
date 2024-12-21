create table pizza_sales(
pizza_id integer,
order_id integer,
pizza_name_id varchar(100),
quantity int,
Order_date date,
order_time time,
unit_price float,
total_price float,
pizza_size varchar(50),
Pizza_category varchar(50),
Pizza_ingredients varchar(100),
pizza_name varchar(100)
);

select * from pizza_sales;
select count(*)from pizza_sales;

--total revenue

select sum(total_price) as total_revenue
from pizza_sales

--average order value

select sum(total_price) / count(distinct order_id) as avg_order_value
from pizza_sales;

--total pizza sales

select sum(quantity) as total_pizza_sold
from pizza_sales;

--total orders

select count(distinct order_id) as total_orders
from pizza_sales;

--average pizza per order

select cast(cast(sum(quantity)as DECIMAL(10,2)) / cast(count(distinct order_id) 
as DECIMAL(10,2)) as DECIMAL(10,2)) as avg_pizza_per_order 
from pizza_sales;

--daily trend for total orders

select to_char(order_date, 'Day') as Order_day, count(distinct order_id) as total_orders
from pizza_sales
group by to_char(order_date, 'Day');

--hourly trend for total orders

select extract(hour from order_time) as order_hours, count(distinct order_id) as total_orders
from pizza_sales
group by extract(hour from order_time)
order by extract(hour from order_time);

--percentage of sales by pizza category

select pizza_category, sum(total_price) * 100 /
(select sum(total_price) from pizza_sales) as Total_sales_percentange
from pizza_sales
group by pizza_category;

--percentage of sales by pizza size

select pizza_size, sum(total_price) * 100 /
(select sum(total_price) from pizza_sales) as Total_sales_percentange
from pizza_sales
group by pizza_size
order by Total_sales_percentange desc;

--total pizza sales by pizza category

select pizza_category, sum(quantity) as total_pizza_sold
from pizza_sales
group by pizza_category;

--top 5 best sellers by total pizza sold

select pizza_name, sum(quantity) as total_pizza_sold
from pizza_sales
group by pizza_name
order by total_pizza_sold desc
limit 5;

--bottom 5 worst sellers by total pizza sold

select pizza_name, sum(quantity) as total_pizza_sold
from pizza_sales
group by pizza_name
order by total_pizza_sold asc
limit 5;



