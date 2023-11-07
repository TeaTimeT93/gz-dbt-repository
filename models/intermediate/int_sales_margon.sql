select date_date,
orders_id,
products_id,
revenue,
quantity,
CAST(purchase_price AS FLOAT64) AS purchase_price,
ROUND(revenue-quantity*CAST(purchase_price AS FLOAT64),2) AS margin
FROM {{ref("stg_raw__sales")}} 
LEFT JOIN {{ref("stg_raw__product")}}
USING (products_id) 
