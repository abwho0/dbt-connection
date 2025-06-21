-- dim_payment_methods.sql

with payment_methods as (

    select * from  {{ref("stg_ajar_oltp__payment_methods")}}
)
select
        payment_method_id
        ,payment_method_name
        ,display_name
        ,provider_name
        ,country_code 
        ,is_enabled
        ,created_date_kwt
        ,updated_date_kwt
        ,created_at_kwt
        ,updated_at_kwt
        ,old_id
        ,old_provider_id

    from payment_methods