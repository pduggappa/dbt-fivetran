
-- Use the `ref` function to select from other models

-- select *
-- from {{ ref('my_first_dbt_model') }}
-- where id = 1

select * from {{ source('wirecutter_final', 'daily_page_metrics_total') }}
