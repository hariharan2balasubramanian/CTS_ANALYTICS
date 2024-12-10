{{ config(materialized = 'view', schema = 'reporting') }}

select 
c.companyname, c.contactname, c.city, sum(o.linesaleamount) as sales, sum(o.quantity) as quantity
from 
{{ref("dim_customers")}} as c inner join
{{ref("fct_orders")}} as o on c.customerid = o.customerid
where c.city=  {{ var('vcity', "'London'")}}
group by c.companyname, c.contactname, c.city
order by sales desc