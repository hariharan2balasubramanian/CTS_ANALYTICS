{{config(materialized='incremental', unique_key='orderid')}}

select * from
{{source('qwt_raw','orders')}}

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where orderdate > (select max(orderdate) from {{ this }})

{% endif %}
