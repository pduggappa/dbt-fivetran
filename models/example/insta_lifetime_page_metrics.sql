select id as insta_page_id, followers_count,name from {{ source('instagram_business_fivatran', 'user_history') }}

