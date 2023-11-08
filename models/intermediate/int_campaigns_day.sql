SELECT date_date,
       SUM(CAST(ads_cost AS FLOAT64)) AS ads_cost,
       SUM(impression) AS ads_impression,
       SUM(click) AS ads_clicks
FROM {{ref("int_campaigns")}}
GROUP BY date_date
ORDER BY date_date ASC