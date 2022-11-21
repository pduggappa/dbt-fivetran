select id as insta_page_id,impressions,reach,website_clicks,date(date) as metric_date from {{ source('instagram_business_fivatran', 'user_insights') }}
