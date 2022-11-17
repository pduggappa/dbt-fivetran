
-- Use the `ref` function to select from other models

-- select *
-- from {{ ref('my_first_dbt_model') }}
-- where id = 1
select * from

(select page_id,date(date) as metric_date,page_impressions,page_post_engagements,page_video_views,page_fans,page_actions_post_reactions_anger_total,page_actions_post_reactions_haha_total
,page_actions_post_reactions_like_total,page_actions_post_reactions_love_total,page_actions_post_reactions_sorry_total,page_actions_post_reactions_wow_total,
 from {{ source('wirecutter_final', 'daily_page_metrics_total') }}) mt
 
 left join
 
(select page_consumptions_by_consumption_type from  {{ source('wirecutter_final', 'daily_page_metrics_by_consumption_type') }}) ct
on mt.metric_date = ct.metric_date
