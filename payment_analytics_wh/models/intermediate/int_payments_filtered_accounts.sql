with

payments as (

   select * from {{ ref('stg_ajar_oltp__payments') }}

)

,accounts as (
    select * from {{ ref('stg_ajar_oltp__accounts') }}
)

,payments_original_accounts as (

   select
      p.* 
      ,kyc_status
      from payments p
        join accounts a on p.account_id = p.account_id
    where kyc_status <> 'Rejected'

)

select * from payments_original_accounts