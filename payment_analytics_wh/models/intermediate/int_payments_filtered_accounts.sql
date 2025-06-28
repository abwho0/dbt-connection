with

payments as (
    select * from {{ ref('stg_ajar_oltp__payments') }}
    {% if is_incremental() %}
        where updated_at_kwt >= (select max(updated_at_kwt) from {{ this }})
    {% endif %}
)

,accounts as (
    select * from {{ ref('stg_ajar_oltp__accounts') }}
)

,payments_deduped as (
    select *
    from (
        select *,
               row_number() over (partition by payment_id order by updated_at_kwt desc) as row_num
        from payments
    )
    where row_num = 1
)

,payments_original_accounts as (

    select
        p.*,
        a.kyc_status
    from payments_deduped p
    join accounts a on p.account_id = a.account_id
    where a.kyc_status <> 'Rejected'
)

select * 
from payments_original_accounts
order by payment_id desc