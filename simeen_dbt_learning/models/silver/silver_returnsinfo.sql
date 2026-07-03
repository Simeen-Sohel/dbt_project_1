With returnsinfo as (
    select 
        sales_id,
        product_sk,
        store_sk,
        refund_amount,
        returned_qty,
        return_reason
    from {{ ref('bronze_returns') }}
),

product as (
    select 
        product_sk,
        category,
        product_name
    from {{ ref('bronze_product') }}
),

store as (
    select 
        store_sk,
        city
    from {{ ref('bronze_store') }}
),

joined_query as (
    select 
        returnsinfo.sales_id,
        returnsinfo.refund_amount,
        returnsinfo.return_reason,
        product.category,
        product.product_name,
        store.city
    from returnsinfo
    join product on returnsinfo.product_sk = product.product_sk
    join store on returnsinfo.store_sk = store.store_sk
)

select 
    category,
    return_reason,
    product_name,
    city,
    sum(refund_amount) as total_refund_amount
from joined_query
group by category, product_name,return_reason,  city
order by total_refund_amount desc