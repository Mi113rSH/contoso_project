WITH customer_last_purchase AS (
	SELECT
		ca.customerkey,
		ca.fullname,
		ca.orderdate,
		row_number()OVER (PARTITION BY ca.customerkey ORDER BY ca.orderdate DESC) AS rn,
		ca.first_purchase_date,
		MAX(ca.orderdate) OVER () AS max_dataset_date,
		ca.cohort_year 
	FROM cohort_analysis ca
),
churned_customers AS (
	SELECT 
		customerkey,
		fullname,
		cohort_year,
		orderdate AS last_purchase_date,
		CASE
			WHEN orderdate <= max_dataset_date  - INTERVAL '6 months' THEN 'Churned'
			ELSE 'Active'
		END AS customer_status
	FROM customer_last_purchase
	WHERE rn = 1
		AND first_purchase_date <= max_dataset_date - INTERVAL '6 months'
)
SELECT 
	cohort_year,
	customer_status,
	count(customerkey) AS num_customers,
	SUM(count(customerkey)) OVER(PARTITION BY cohort_year) AS total_customers,
	ROUND(count(customerkey) * 100.0 / SUM(count(customerkey)) OVER(PARTITION BY cohort_year),2) AS status_percentange
 FROM churned_customers 
 GROUP BY 
 	cohort_year,
 	customer_status 
;