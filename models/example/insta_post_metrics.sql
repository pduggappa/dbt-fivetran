select distinct mh.media_id,username,media_type,permalink,is_story,
                    case when media_type = 'IMAGE' THEN video_views
                         when media_type = 'VIDEO' THEN reel_plays
                         when media_type = 'CAROUSEL_ALBUM' THEN carousel_album_video_views
                         end as video_views,
                    case when media_type = 'IMAGE' THEN video_photo_engagement
                         when media_type = 'VIDEO' THEN reel_total_interactions
                         when media_type = 'CAROUSEL_ALBUM' THEN carousel_album_engagement
                         end as Engagements,
                    case when media_type = 'IMAGE' THEN video_photo_reach
                         when media_type = 'VIDEO' THEN reel_reach
                         when media_type = 'CAROUSEL_ALBUM' THEN carousel_album_reach
                         end as Reach,
                    case when media_type = 'IMAGE' THEN video_photo_impressions
                         when media_type = 'VIDEO' THEN reel_plays
                         when media_type = 'CAROUSEL_ALBUM' THEN carousel_album_impressions
                         end as Impressions,
                    case when media_product_type = 'STORY' THEN story_taps_back end as story_taps_back,
                    case when media_type = 'IMAGE' THEN video_photo_saved 
                         when media_type = 'VIDEO' THEN reel_saved
                         when media_type = 'CAROUSEL_ALBUM' THEN carousel_album_saved
                         end as saves,
                         like_count,comment_count,reel_shares
from 

(SELECT user_id as page_id,id as media_id, media_type, media_product_type,permalink,username,is_story
FROM (
    SELECT *, ROW_NUMBER() OVER(partition by id order by _fivetran_synced desc) rn
    FROM {{ source('instagram_business_fivatran', 'media_history') }}
) t1
WHERE rn = 1
ORDER BY media_id
) mh

left join 

(SELECT id as media_id,_fivetran_synced, like_count,comment_count,reel_likes,carousel_album_engagement,carousel_album_impressions,video_photo_engagement,video_photo_reach,
carousel_album_reach,carousel_album_saved,carousel_album_video_views,video_photo_impressions,reel_comments,reel_plays,
reel_reach,reel_saved,reel_shares,reel_total_interactions,video_views,story_taps_back,video_photo_saved
FROM (
    SELECT *, ROW_NUMBER() OVER(partition by id order by _fivetran_synced desc) rk
    FROM {{ source('instagram_business_fivatran', 'media_insights') }}
) t1
WHERE rk = 1
ORDER BY media_id) mi

on mh.media_id = mi.media_id







