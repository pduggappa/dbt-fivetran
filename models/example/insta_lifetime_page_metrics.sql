select id as insta_page_id, date(_fivetran_synced) as latest_date, followers_count,name from {{ source('instagram_business_fivatran', 'user_history') }}

