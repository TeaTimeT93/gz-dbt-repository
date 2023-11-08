SELECT b.*,
       (operational_margin - ads_cost) AS ads_margin,
       a.operational_margin
FROM {{ref("finance_days")}} a
INNER JOIN {{ref("int_campaigns_day")}} b
USING(date_date)