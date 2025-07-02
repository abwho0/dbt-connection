-- dim_accounts.sql

with accounts as (

    select * from  {{ref("stg_ajar_oltp__accounts")}}
)

,accounts_deduped as (
    select *
    from (
        select *,
               row_number() over (partition by account_id order by updated_at_kwt desc) as row_num
        from accounts
    )
    where row_num = 1
)

select
        account_id
        ,account_name
        ,kyc_status
        ,is_registered_company
        ,created_date_kwt
        ,updated_date_kwt
        ,archived_date_kwt
        ,created_at_kwt
        ,updated_at_kwt

    from accounts_deduped