select mh.media_id, case when media_type = 'IMAGE' THEN video_views
                         when media_type = 'VIDEO' THEN reel_plays
                         when media_type = 'CAROUSEL_ALBUM' THEN carousel_album_video_views
                         end as video_views,
                    like_count,comment_count,reel_likes,reel_reach
from 

(select user_id as page_id,id as media_id, media_type, permalink,username from {{ source('instagram_business_fivatran', 'media_history') }}) mh

left join 

(select id as media_id, like_count,comment_count,reel_likes,carousel_album_engagement,carousel_album_impressions
carousel_album_reach,carousel_album_saved,carousel_album_video_views,reel_comments,reel_plays,
reel_reach,reel_saved,reel_shares,reel_total_interactions,video_views from {{ source('instagram_business_fivatran', 'media_insights') }}) mi

on mh.media_id = mi.media_id