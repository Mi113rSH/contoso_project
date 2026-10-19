# Contoso Dataset Sales Analysis

## Overview
    This project is a comprehensive end-to-end business intelligence and data analytics portfolio project based on the Contoso sales dataset.

    The primary objective is to evaluate the overall health of the customer lifecycle, focusing on Lifetime Value (LTV) segmentation, acquisition cohort trends, and long-term retention behavior.

    Using PostgreSQL for advanced data modeling (including window functions, dynamic thresholds, and survival bias prevention) and Looker Studio for executive reporting, this analysis diagnoses a critical business challenge: a structural "leaky bucket" where aggressive customer acquisition has masked declining per-customer revenue and a systemic 90% churn rate.

    Ultimately, this repository transitions from raw SQL data manipulation into actionable, data-driven strategic recommendations designed to shift the company from an unsustainable mass-acquisition model toward a profitable, retention-focused framework.

## Business Questions
1. Customer segmentation:
	* Who are our most valuable customers?
2. Cohort Analysis:
	* How do different groups generate revenue?
3. Retention Analysis:
	* Who hasn't purchased anything recently?

## Executive Dashboard
To view the interactive visualizations, filtering capabilities, and dynamic metrics, please visit the live dashboard.

**🔗 [View Live Interactive Dashboard on Data Studio](https://datastudio.google.com/reporting/75f5dd68-f5d4-4375-8883-a5e8031be7b2)**

## Analysis Approach

### 1. Customer Segmentation
- Aggregated total net revenue per customer across historical transaction records.
- Defined the global percentiles dynamically crossing information from different tables such as Sales and Customer to establish objective threshold boundaries.
- Categorized the customers into three distinct tiers (Low-Value, Mid-Value, High-Value) based on their comparative yield.

    Query: [1_customer_segmentation](/Scripts/1_customer_segmentation.sql)

**Visualization**
![Cohort Analysis](/images/revenue_share_by_tier.png)
![Cohort Analysis](/images/avg_ltv_customer_total.png)

**Key Findings**
- **The Pareto Concentration (Donut Chart):** A minority high-value bracket drives roughly **65.6%** of total net revenue (~135.4M out of 206M total), proving a heavy reliance on top-tier buyers.
- **The Volume Backbone (Combo Chart):** The mid-value segment forms the foundational baseline of the customer base with the largest headcount (~25K customers), balancing strong transaction counts with steady monetary contribution.
- **Yield vs. Volume Contrast:** While the high-value tier commands a lower total customer count (~12.5K), their average LTV line towers over the rest, showing that individual wallet share matters more than raw acquisition volume in this bracket.

**Business Insights**
- Retention and loyalty strategies should prioritize safeguarding the high-value and mid-value tiers.
- Future acquisition budgets should look to replicate the behavioral traits of the top 25% threshold rather than focusing solely on raw customer volume.
- Design re-engagement campaigns and price-sensitive promotions to increase purchase frequency.

### 2. Cohort Analysis
- Tracked revenue and customer count per cohort.
- Cohorts were grouped by year of first purchase.
- Analyzed customer retention at a cohort level.

    Query: [2_cohort_analysis.sql](/Scripts/2_cohort_analysis.sql)

**Visualization**

![Cohort Analysis](/images/cohort_analysis.png)

**Key Findings**
- **The Inverse Relationship (Value vs. Volume):** In the early high-value period (2015–2017), individual customer revenue hovered around 5.5K while total customers remained lower at 2.5K–4K. Conversely, during mass-scale pushes (2018–2019 and 2022), customer volume surged—peaking near 9K in 2022—while individual customer revenue noticeably declined.
- **Recent Contraction (2023–2024):** Both customer acquisition volume and individual revenue contracted sharply, extending a multi-year downward trajectory across both metrics.

**Business Insights**
- **Yield Decay:** The shift from a high-yield boutique model to a high-volume framework indicates that aggressive scaling brought in lower-intent or lower-budget buyers, reducing overall customer value extraction over time.
- **Post-Peak Volatility:** The sudden drop in customer acquisition following the 2022 high-water mark highlights potential instability in marketing channels, signaling that current acquisition strategies are losing momentum.
- **Strategic Pivot Required:** With both acquisition volume and customer yield trending downward, the business must re-evaluate its target audience profiles and shift focus toward retention quality rather than raw volume to protect future revenue.

### 3. Retention Analysis
- Defined a 6-month inactivity window to classify a customer as 'Churned'.
- Identified customers at risk of churning.
- Calculated customer-specific metrics.

    Query: [3_retention_analysis.sql](/Scripts/3_retention_analysis.sql)

**Visualization**
    ![Active VS Churned Customers by Cohort Year](/images/activevschurned.png)

**Key Findings**
- **Systemic, Uniform Churn**: Across all nine observed cohorts (2015–2023), mature customer churn consistently dominates at approximately 90%.
- **Minimal Retention Baseline**: The active customer base is remarkably static, hovering around 10% regardless of the year the cohort was acquired.
- **No Volume-to-Loyalty Translation**: The massive influx of new customers identified during the 2022 acquisition push did not translate into a higher retention rate, mirroring the exact same churn behavior as the early 2015–2017 cohorts, signaling that without intervention, future cohorts will follow the same pattern.

**Business Insights**
- Instead of continuing to pour marketing budget into raw acquisition, the company must investigate the structural reasons for customer abandonment (e.g., product quality, post-purchase experience, or lack of recurring value) and develop targeted re-engagement campaigns for the 90% dormant user base.
- Strengthen early engagement strategies to target the first 1-2 years with onboarding incentives and personalized offers to improve long-term retention.
- Re-engage high-value churned customers by focusing on targeted win-back campaigns rather than broad retention efforts, as reactivating valuable users may yield higher ROI (Return On Investment). 

## Strategic Recommendations

1. **Shift Budget from Mass Acquisition to Retention**
    * The company must immediately pause expensive, top-of-funnel mass marketing. Acquiring new users who are almost guaranteed to churn within 6 months yields a negative ROI. Instead, redirect that budget into post-purchase onboarding, customer experience improvements, and loyalty incentives designed to break the 10% retention ceiling.
2. **Realign Marketing Around the High-Value "Pareto" Profile**
    * Stop optimizing ad campaigns for raw volume or low Customer Acquisition Cost (CAC). Data science and marketing teams should collaborate to reverse-engineer the demographic and behavioral traits of the top 25% "High-Value" tier. Future acquisition campaigns must specifically target this Ideal Customer Profile (ICP) to prioritize quality and lifetime wallet share over simple headcount.
3. **Launch a Value-Tiered Win-Back Campaign**
    * Deploy a targeted reactivation strategy, but do not treat all churned users equally. Cross-reference the churn database with the LTV segmentation to identify users who were formerly in the "High-Value" or "Mid-Value" tiers before they lapsed. Offer these specific individuals aggressive, personalized re-engagement incentives (like steep discounts or exclusive access), as their historical data proves they have the highest potential financial yield if successfully reactivated.

## Technical Details
- **Database:** PostgreSQL
- **Analysis Tools:** PostgreSQL
- **Visualization:** Google Data Studio