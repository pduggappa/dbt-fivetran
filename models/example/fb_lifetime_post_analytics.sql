select qq.date,qq.post_id,post_impressions,engagement,post_clicks,post_reactions_anger_total,post_reactions_haha_total,post_reactions_like_total,post_reactions_love_total,post_reactions_sorry_total,post_reactions_wow_total,share_count,media_type from
(SELECT date(metric_date) date,post_id,sum(post_clicks+post_reactions_anger_total+post_reactions_haha_total+post_reactions_like_total+post_reactions_love_total+post_reactions_sorry_total+post_reactions_wow_total+share_count) as engagement
FROM (
    SELECT *, ROW_NUMBER() OVER(partition by post_id order by metric_date desc) rn
    FROM `nyt-wccomposer-dev.dbt_social_transforms.fb_lifetime_post_analytics`
) t1
WHERE rn = 1
group by date,post_id
ORDER BY post_id)qq

left join 

(select date(metric_date) date,post_id,post_clicks,post_reactions_anger_total,post_reactions_haha_total,post_reactions_like_total,post_reactions_love_total,post_reactions_sorry_total,post_reactions_wow_total,share_count,media_type,post_impressions from (
    SELECT *, ROW_NUMBER() OVER(partition by post_id order by metric_date desc) rn
    FROM `nyt-wccomposer-dev.dbt_social_transforms.fb_lifetime_post_analytics`
) t1
WHERE rn = 1)pp
on qq.post_id = pp.post_id
