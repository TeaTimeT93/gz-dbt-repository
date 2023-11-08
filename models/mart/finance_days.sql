--{{ config(materialized = 'table') }}

WITH tab1 AS (
SELECT
  o.orders_id
  ,o.date_date
  ,ROUND(o.margin + s.shipping_fee - (s.logcost + CAST(s.ship_cost AS FLOAT64)),2) AS operational_margin 
  ,o.quantity
  ,o.revenue
  ,o.purchase_price
  ,o.margin
  ,s.shipping_fee
  ,s.logcost
  ,s.ship_cost
FROM `modular-analog-402210`.`dbt_`.`int_orders_operational` o
LEFT JOIN `modular-analog-402210`.`dbt_`.`stg_raw__ship` s 
	USING(orders_id)
ORDER BY orders_id desc
)

SELECT date_date,
       COUNT(orders_id) AS nb_transaction,
       ROUND(SUM(revenue),0) AS revenue,
       ROUND(AVG(revenue),1) AS average_basket,
       ROUND(SUM(margin),0) AS margin,
       ROUND(SUM(op_margin),0) AS operational_margin 
FROM {{ref("int_orders_operational")}}
GROUP BY date_date
ORDER BY date_date DESC