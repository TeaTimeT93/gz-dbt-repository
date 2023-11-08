SELECT orders_id,date_date,
    SUM(revenue) AS revenue,
	ROUND(SUM(quantity),2) as quantity,
	ROUND(SUM(purchase_price),2) as purchase_price,
	ROUND(SUM(margin),2) as margin,
    ROUND(SUM((margin+s.shipping_fee-s.logcost-CAST(s.ship_cost AS FLOAT64))),2) AS op_margin
FROM {{ref("int_sales_margin")}}
LEFT JOIN {{ref("stg_raw__ship")}} s
USING (orders_id)
GROUP BY orders_id,date_date
ORDER BY orders_id DESC