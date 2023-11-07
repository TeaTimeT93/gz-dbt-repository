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
    (revenue) AS revenue,
	ROUND((quantity),2) as quantity,
	ROUND((purchase_price),2) as purchase_price,
	ROUND((margin),2) as margin,
    ROUND((margin+s.shipping_fee-s.logcost-CAST(s.ship_cost AS FLOAT64),2)) AS op_margin
FROM tabl1
LEFT JOIN {{ref("stg_raw__ship")}} s
USING (orders_id)
ORDER BY orders_id DESC