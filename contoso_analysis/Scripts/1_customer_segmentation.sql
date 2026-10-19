--Most valuable customers
WITH customer_ltv AS (
	SELECT
		customerkey,
		fullname,
		SUM(total_net_revenue) AS total_ltv
	FROM cohort_analysis
	GROUP BY
		customerkey,
		fullname
),
customer_segments AS (
	SELECT
		PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY total_ltv) AS ltv_25th_perc,
		PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY total_ltv) AS ltv_75th_perc
	FROM customer_ltv 
),
segment_values AS (
	SELECT
		c.customerkey,
		c.fullname,
		c.total_ltv,
		CASE
			WHEN c.total_ltv <= cs.ltv_25th_perc THEN 'Low-Value'
			WHEN c.total_ltv >= cs.ltv_75th_perc THEN 'High-Value'
			ELSE 'Mid-value'
		END AS customer_value
	FROM 
		customer_ltv c
	CROSS JOIN
		customer_segments cs
)
SELECT
	customer_value,
	SUM(total_ltv) AS total_ltv,
	COUNT(customerkey) AS customer_count,
	SUM(total_ltv) / COUNT(customerkey) AS avg_ltv
FROM segment_values
GROUP BY customer_value