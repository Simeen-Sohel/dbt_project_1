with dedup_query as (
    select
        * , row_number() over (partition by item_id order by update_date desc) as deduplication_id
    from {{ source('source', 'items_wd') }}
)
select 
    item_id, item_name, category, update_date
from dedup_query
where deduplication_id = 1