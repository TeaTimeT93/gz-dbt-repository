WITH tabl1 AS(
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
)

SELECT orders_id,date_date,
    SUM(revenue) AS revenue,
	ROUND(SUM(quantity),2) as quantity,
	ROUND(SUM(purchase_price),2) as purchase_price,
	ROUND(SUM(margin),2) as margin--,
    --ROUND(SUM(margin+s.shipping_fee-s.logcost-CAST(s.ship_cost AS FLOAT64),2)) AS op_margin
FROM tabl1
LEFT JOIN {{ref("stg_raw__ship")}} s
USING (orders_id)
GROUP BY orders_id,date_date
ORDER BY orders_id DESC