WITH table1 AS(
SELECT DATE_TRUNC(date_date, MONTH) AS date_month,
        SUM(ads_cost) AS ads_cost,
        SUM(ads_impression) AS ads_impression,
        SUM(ads_clicks) AS ads_clicks,
        SUM(ads_margin) AS ads_margin,
        SUM(operational_margin) AS operational_margin,
FROM {{ref("finance_campaigns_day")}}
GROUP BY DATE_TRUNC(date_date, MONTH)
)

SELECT *
FROM table1
ORDER BY date_month DESC