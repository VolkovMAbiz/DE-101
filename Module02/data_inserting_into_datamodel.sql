insert into products_dim
select distinct product_id,category,subcategory,product_name from orders 

truncate table products_dim cascade
select * from products_dim
where product_id = 'OFF-BI-10002827'

select * from orders_body_dim obd 

select * from customer_dim cd 

select * from orders o 

set datestyle to 'ISO, MDY';
insert into customer_dim
select distinct customer_id,cast('12-03-2001' as date),1,'text',1,cast('12-03-2001' as date),segment from orders

insert into regional_manager_dim 
select distinct region,person from people 

select * from regional_manager_dim rmd 

truncate table order_date_calendar cascade
insert into ship_date_calendar 
select distinct ship_date ,extract(year from ship_date)::int,11,11,extract(month from ship_date)::int,11,11,11,11 from orders

select * from ship_date_calendar sdc 
select * from order_date_calendar odc 

alter table orders_headers_facts alter column returned_status drop not null
alter table orders_headers_facts alter column "postal code" drop not null

insert into orders_headers_facts 
select distinct o.order_id,order_date,ship_date,ship_mode ,customer_id ,country ,region ,city,state,postal_code,sum(sales),sum(profit),sum(discount),returned from orders o left join returns r on r.order_id = o.order_id group by o.order_id,order_date,ship_date,ship_mode ,customer_id ,country ,region ,city,state,postal_code,returned 

select * from orders_headers_facts ohf 


select * from orders



insert into orders_body_dim 
select row_id,product_id ,quantity ,sales/quantity,sales,profit,discount,order_id from orders 

select * from orders_body_dim obd 
