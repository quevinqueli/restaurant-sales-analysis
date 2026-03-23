-- ================================================
-- RESTAURANT SALES ANALYSIS
-- Analyst: Quévin Quéli
-- Date: March 2026
-- Dataset: Steakhouse POS Data (5,000 transactions)
-- Tool: Google BigQuery (SQL)
-- ================================================


-- Business Question 1: Which day of the week generates the most revenue?
-- Finding: Saturday is the strongest revenue day, Friday second, Sunday third. Thursday is the weakest day.
-- Recommendation: Increase staffing on weekends especially Saturday. Consider a Thursday promotion or reduced staffing to cut costs.

SELECT 
    CASE EXTRACT(DAYOFWEEK FROM date)
        WHEN 1 THEN 'Sunday'
        WHEN 2 THEN 'Monday'
        WHEN 3 THEN 'Tuesday'
        WHEN 4 THEN 'Wednesday'
        WHEN 5 THEN 'Thursday'
        WHEN 6 THEN 'Friday'
        WHEN 7 THEN 'Saturday'
    END AS day_of_week,
    SUM(revenue) AS total_revenue
FROM `steak-house-restaurant-pos.restaurant_pos.steak_house`
GROUP BY day_of_week
ORDER BY total_revenue DESC;


-- Business Question 2: What are the top 10 best selling items by revenue?
-- Finding: New York Strip, Filet Mignon and Ribeye Steak are the top 3 best selling items alongside Bourbon BBQ Burger, Cabernet Sauvignon, Shrimp Cocktail, Old Fashioned, Caesar Salad, Chocolate Lava Cake and Grilled Asparagus.
-- Recommendation: Ensure these 10 items are always fully stocked and prominently featured on the menu. Consider creating a "Chef's Favorites" section highlighting the top 3 steaks as they drive the most revenue. Never run out of New York Strip, Filet Mignon or Ribeye as these are your highest earning items.

SELECT
    menu_item,
    SUM(quantity) AS total_quantity,
    SUM(revenue) AS total_revenue
FROM `steak-house-restaurant-pos.restaurant_pos.steak_house`
GROUP BY menu_item
ORDER BY total_revenue DESC
LIMIT 10;


-- Business Question 3: Which hours are the busiest by day?
-- Finding: Saturday 21:30 is the single most profitable slot at €3,178 revenue. Evening slots between 19:00-22:30 consistently dominate across all days. Saturday and Sunday evenings are the strongest periods overall. Tuesday 21:15 surprisingly performs as strong as weekend evenings at €2,828.
-- Recommendation: Ensure maximum staffing between 19:00-22:30 every day without exception. Saturday evening is your golden window -- never be understaffed on Saturday night. Tuesday evening is an underrated opportunity -- consider a Tuesday dinner promotion to push it even higher. Schedule senior and best performing staff during 19:00-22:30 shifts to maximise upselling and table turnover during peak revenue windows.

SELECT 
    CASE EXTRACT(DAYOFWEEK FROM date)
        WHEN 1 THEN 'Sunday'
        WHEN 2 THEN 'Monday'
        WHEN 3 THEN 'Tuesday'
        WHEN 4 THEN 'Wednesday'
        WHEN 5 THEN 'Thursday'
        WHEN 6 THEN 'Friday'
        WHEN 7 THEN 'Saturday'
    END AS day_of_week,
    time,
    SUM(revenue) AS total_revenue,
    SUM(quantity) AS total_quantity
FROM `steak-house-restaurant-pos.restaurant_pos.steak_house`
GROUP BY day_of_week, time
ORDER BY total_revenue DESC
LIMIT 14;


-- Business Question 4: Which server generates the most revenue?
-- Finding: Nina (ID 105) is the top performing server at €91,507 total revenue. Emily (ID 103) is the lowest at €83,565 -- a €7,942 gap between best and worst. All 5 servers perform relatively closely suggesting a well trained team overall.
-- Recommendation: Recognise and reward Nina as top performer -- her upselling technique should be studied and shared with the rest of the team. Investigate what Nina does differently -- does she recommend drinks more? Suggest desserts? Consider pairing Emily with Nina during peak shifts for mentoring opportunities. The €7,942 revenue gap between best and worst server represents real money -- closing that gap through staff training could add thousands in annual revenue.

SELECT
    server_name,
    server_id,
    SUM(revenue) AS total_revenue
FROM `steak-house-restaurant-pos.restaurant_pos.steak_house`
GROUP BY server_name, server_id
ORDER BY total_revenue DESC;


-- Business Question 5: What is the revenue split between order types?
-- Finding: Delivery is the top revenue channel at €151,637 across 1,728 orders. Dine-In and Takeaway are very close at €144,709 and €143,978 respectively. All three channels perform remarkably similarly suggesting a well balanced operation. Delivery generates the most revenue but also has the most orders -- meaning average order value is similar across all three channels.
-- Recommendation: Delivery is clearly a strong channel -- ensure delivery operations are fully optimised with reliable partners like Uber Eats or Deliveroo. Since all three channels perform similarly, focus on growing delivery volume as it has the highest revenue ceiling with lowest overhead per order. Consider a delivery-only promotion to push delivery orders even higher as it is already your strongest channel.

SELECT 
    order_type,
    SUM(revenue) AS total_revenue,
    COUNT(order_type) AS total_orders
FROM `steak-house-restaurant-pos.restaurant_pos.steak_house`
GROUP BY order_type
ORDER BY total_revenue DESC;











































