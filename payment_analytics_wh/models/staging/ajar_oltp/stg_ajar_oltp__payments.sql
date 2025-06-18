-- stg_ajar_oltp__payments.sql
with

source as (

    select * from {{ source('ajar_oltp_payments','yesterday_payments') }}

),

renamed as (

    select
        -- ids
        id as payment_id
        ,broker_id as account_id
        ,payment_method_id

        -- strings
        ,status as payment_status
        ,case
            when offline = true then 'offline'
            else 'online'
        end as payment_type
        ,currency

        -- numerics
        ,amount

        -- dates
        ,DATE(TIMESTAMP(created_at), "Asia/Kuwait") AS created_date_kwt
        ,DATE(TIMESTAMP(updated_at), "Asia/Kuwait") AS updated_date_kwt
        ,DATE(TIMESTAMP(captured_at), "Asia/Kuwait") AS captured_date_kwt


        -- timestamps
        ,DATETIME(TIMESTAMP(created_at), "Asia/Kuwait") AS created_at_kwt
        ,DATETIME(TIMESTAMP(updated_at), "Asia/Kuwait") AS updated_at_kwt
        ,DATETIME(TIMESTAMP(captured_at), "Asia/Kuwait") AS captured_at_kwt



    from source

)

select * from renamed