select  * from

(select post_id,date(date) as metric_date,post_clicks,post_impressions,post_reactions_anger_total,post_reactions_haha_total,post_reactions_like_total,post_reactions_love_total,post_reactions_sorry_total,post_reactions_wow_total,
 post_video_views
 from {{ source('wirecutter_final', 'lifetime_post_metrics_total') }}) lmt
 
 left join
 
(select post_id,url,media_type from  {{ source('wirecutter_final', 'post_attachment_history') }}) pah
on lmt.post_id = pah.post_id

left join

(select id as post_id,share_count from {{ source('wirecutter_final', 'post_history') }}) ph
on lmt.post_id = ph.post_id
