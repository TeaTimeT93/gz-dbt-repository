select date_date,
orders_id,
ROUND(SUM(revenue),2) AS revenue,
ROUND(SUM(quantity),2) AS quantity,
ROUND(SUM(CAST(purchase_price AS FLOAT64)),2) AS purchase_price,
ROUND(SUM(revenue-quantity*CAST(purchase_price AS FLOAT64)),2) AS margin
FROM {{ref("stg_raw__sales")}} 
LEFT JOIN {{ref("stg_raw__product")}}
USING (products_id) 
GROUP BY date_date,orders_id
ORDER BY orders_id DESC