-- dim_countries.sql

with countries as (
    select 
    distinct currency 
    ,case 
    when currency = 'KWD' then 'Kuwait'
    when currency = 'AED' then 'UAE'
    when currency = 'BHD' then 'Bahrain'
    when currency = 'QAR' then 'Qatar'
    when currency = 'SAR' then 'KSA'
    else ''
    end as country
    from {{ref("stg_ajar_oltp__payments")}}
)

select * from countries