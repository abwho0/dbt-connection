-- stg_ajar_oltp__accounts.sql
with

source as (

    select * from {{ source('ajar_oltp_accounts','customer_accounts') }}

),

renamed as (

    select
        -- ids
        id as account_id
        ,created_by
        ,updated_by

        -- strings
        ,name as account_name
        ,contact_email
        ,contact_phone

        --booleans
        ,kyc_status
        ,is_registered_company

                -- dates
        ,DATE(TIMESTAMP(created_at), "Asia/Kuwait") AS created_date_kwt
        ,DATE(TIMESTAMP(updated_at), "Asia/Kuwait") AS updated_date_kwt
        ,DATE(TIMESTAMP(archived_at), "Asia/Kuwait") AS archived_date_kwt


        -- timestamps
        ,DATETIME(TIMESTAMP(created_at), "Asia/Kuwait") AS created_at_kwt
        ,DATETIME(TIMESTAMP(updated_at), "Asia/Kuwait") AS updated_at_kwt

    from source

)

select * from renamed