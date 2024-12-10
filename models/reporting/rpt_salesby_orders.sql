{{ config(materialized = 'view', schema = 'reporting') }}

select c.companyname, c.contactname, 
min(o.orderdate) as first_order_date,
max(o.orderdate) as last_order_date,
count(o.orderid) as total_orders, 
sum(o.linesaleamount) as total_sales, 
avg(o.margin) as avg_margin
from 
{{ref("dim_customers")}} as c inner join
{{ref("fct_orders")}} as o on c.customerid = o.customerid
group by c.companyname, c.contactname
order by total_sales desc