---fct_payments joined on captured_date with dim_date

SELECT
     p.payment_id 
    ,p.amount
    ,p.payment_type
    ,payment_status

    ,p.currency
    ,c.country

    ,p.account_id
    ,a.account_name
    ,a.kyc_status

    ,p.payment_method_id
    ,pm.display_name
    ,pm.provider_name
    ,pm.is_enabled

    ,p.created_at_kwt
    ,p.updated_at_kwt
    ,p.captured_at_kwt

    ,p.created_date_kwt
    ,p.updated_date_kwt
    ,p.captured_date_kwt


FROM {{ ref('int_payments_filtered_accounts') }} p
LEFT JOIN {{ ref('dim_accounts') }} a ON p.account_id = a.account_id
LEFT JOIN {{ ref('dim_payment_methods') }} pm ON p.payment_method_id = pm.payment_method_id
LEFT JOIN {{ ref('dim_country') }} c ON p.currency = c.currency
LEFT JOIN {{ ref('dim_date') }} d ON p.captured_date_kwt = d.date_day