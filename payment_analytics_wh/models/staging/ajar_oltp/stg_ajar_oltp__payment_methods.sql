-- stg_ajar_oltp__payment_methods.sql
with

source as (

    select * from {{ source('ajar_oltp_payments','payment_methods') }}

),

renamed as (

    select
        -- ids
        id as payment_method_id

        -- strings
        ,name as payment_method_name
        ,case 
        when display_name = 'knet' then 'KNET'
        when display_name = 'card_credit_debit' then 'Credit Card'
        end as display_name
        ,provider_name
        ,country_code 

        --booleans
        ,is_enabled

                -- dates
        ,DATE(TIMESTAMP(created_at), "Asia/Kuwait") AS created_date_kwt
        ,DATE(TIMESTAMP(updated_at), "Asia/Kuwait") AS updated_date_kwt

        -- timestamps
        ,DATETIME(TIMESTAMP(created_at), "Asia/Kuwait") AS created_at_kwt
        ,DATETIME(TIMESTAMP(updated_at), "Asia/Kuwait") AS updated_at_kwt

        --old ids
        ,temp_method_id as old_id
        ,temp_provider_id as old_provider_id

    from source

)

select * from renamed