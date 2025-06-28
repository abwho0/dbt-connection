with

payments as (
    select * from {{ ref('stg_ajar_oltp__payments') }}
),

accounts as (
    select * from {{ ref('stg_ajar_oltp__accounts') }}
),

payments_original_accounts as (

    select
        p.*,
        a.kyc_status
    from payments p
    join accounts a on p.account_id = a.account_id
    where a.kyc_status <> 'Rejected'

    {% if is_incremental() %}
      and p.updated_at_kwt > (select max(updated_at_kwt) from {{ this }})
    {% endif %}
)

select * from payments_original_accounts