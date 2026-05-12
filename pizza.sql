create database pizzahunt;
use pizzahunt;

-- imported tables
show tables;

-- all table viwe 
select * from order_details;
select * from orders;
select * from pizzas;
select * from pizza_types;

-- total sale and total quantity sold
select round(sum(price) )as totalsale, 
count(quantity) as quantitysold
from order_details as d
join pizzas as p on p.pizza_id = d.pizza_id;

-- Which day has the highest sales? 
select 
o.date ,
count(quantity)as totalquantity,sum(price)as totalsale
from order_details as d
join orders o on d.order_id = o.order_id 
join pizzas P on d.pizza_id = p.pizza_id
group by o.date 
order by totalsale desc 
limit 1;

-- what size mostly sales
select p.size, count(quantity) as totalquantity
from order_details as d
join orders o on d.order_id = o.order_id 
join pizzas P on d.pizza_id = p.pizza_id
group by p.size
order by totalquantity desc;

-- top 3 most pizzas type sold 
select p.pizza_id, count(quantity) as totalquantity
from order_details as d
join orders o on d.order_id = o.order_id 
join pizzas P on d.pizza_id = p.pizza_id
group by p.pizza_id
order by totalquantity desc 
limit 3;

-- Find total quantity sold per pizza category.
select category,
count(quantity)
from pizzas as p
join pizza_types t on t.pizza_type_id = p.pizza_type_id
join order_details d on d.pizza_id = p.pizza_id
join orders o on o.order_id = d.order_id
group by category;

-- Which pizza category generates the most profit?
select name,round(sum(price))as totalprice
from pizzas as p
join order_details as d on d.pizza_id = p.pizza_id
join pizza_types as t on t.pizza_type_id = p.pizza_type_id
group by name
order by totalprice desc
limit 1 ;

-- dashboard viwe 
create View sales_dashboard as
select  o.date as date ,
 t.name as name,
 p.size as size,
count(quantity)as total_quantity,
round(sum(price))as revenue
from orders as o
join order_details as d on d.order_id = o.order_id 
join pizzas as p on p.pizza_id = d.pizza_id
join pizza_types as t on t.pizza_type_id = p.pizza_type_id
group by o.date , t.name , p.size ;

-- sales dashbard viwe
select * from sales_dashboard;

-- Find average number of pizzas ordered per day.
select  avg(total_quantity)
from sales_dashboard;

