select mh.media_id, case when media_type = 'IMAGE' THEN video_views
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
                    like_count,comment_count
from 

(select user_id as page_id,id as media_id, media_type, permalink,username,is_story from `nyt-wccomposer-dev`.`instagram_business_fivatran`.`media_history`) mh

left join 

(select id as media_id,_fivetran_synced, like_count,comment_count,reel_likes,carousel_album_engagement,carousel_album_impressions,video_photo_engagement,video_photo_reach,
carousel_album_reach,carousel_album_saved,carousel_album_video_views,video_photo_impressions,reel_comments,reel_plays,
reel_reach,reel_saved,reel_shares,reel_total_interactions,video_views from `nyt-wccomposer-dev`.`instagram_business_fivatran`.`media_insights`) mi

on mh.media_id = mi.media_id
