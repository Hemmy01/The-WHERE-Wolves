-- Create the sales table
CREATE TABLE electronics_sales_1 (
    sale_id NUMBER PRIMARY KEY,
    product_name VARCHAR2(100),
    category VARCHAR2(50),
    region VARCHAR2(50),
    sale_date DATE,
    quantity NUMBER,
    unit_price NUMBER,
    total_amount NUMBER
);

-- Insert sample data
INSERT INTO electronics_sales_1 VALUES (1, 'iPhone 14 Pro', 'Smartphones', 'North', TO_DATE('2023-01-05', 'YYYY-MM-DD'), 10, 999, 9990);
INSERT INTO electronics_sales_1 VALUES (2, 'Samsung Galaxy S23', 'Smartphones', 'South', TO_DATE('2023-01-10', 'YYYY-MM-DD'), 8, 899, 7192);
INSERT INTO electronics_sales_1 VALUES (3, 'MacBook Pro', 'Laptops', 'East', TO_DATE('2023-01-15', 'YYYY-MM-DD'), 5, 1499, 7495);
INSERT INTO electronics_sales_1 VALUES (4, 'Dell XPS 13', 'Laptops', 'West', TO_DATE('2023-01-20', 'YYYY-MM-DD'), 4, 1299, 5196);
INSERT INTO electronics_sales_1 VALUES (5, 'iPad Air', 'Tablets', 'North', TO_DATE('2023-01-25', 'YYYY-MM-DD'), 12, 599, 7188);
INSERT INTO electronics_sales_1 VALUES (6, 'Samsung Tab S8', 'Tablets', 'South', TO_DATE('2023-02-05', 'YYYY-MM-DD'), 7, 649, 4543);
INSERT INTO electronics_sales_1 VALUES (7, 'Sony PlayStation 5', 'Gaming', 'East', TO_DATE('2023-02-10', 'YYYY-MM-DD'), 6, 499, 2994);
INSERT INTO electronics_sales_1 VALUES (8, 'Xbox Series X', 'Gaming', 'West', TO_DATE('2023-02-15', 'YYYY-MM-DD'), 5, 499, 2495);
INSERT INTO electronics_sales_1 VALUES (9, 'AirPods Pro', 'Audio', 'North', TO_DATE('2023-02-20', 'YYYY-MM-DD'), 20, 249, 4980);
INSERT INTO electronics_sales_1 VALUES (10, 'Bose QC45', 'Audio', 'South', TO_DATE('2023-02-25', 'YYYY-MM-DD'), 9, 329, 2961);
INSERT INTO electronics_sales_1 VALUES (11, 'iPhone 13', 'Smartphones', 'East', TO_DATE('2023-03-05', 'YYYY-MM-DD'), 12, 799, 9588);
INSERT INTO electronics_sales_1 VALUES (12, 'Google Pixel 7', 'Smartphones', 'West', TO_DATE('2023-03-10', 'YYYY-MM-DD'), 6, 599, 3594);
INSERT INTO electronics_sales_1 VALUES (13, 'HP Spectre', 'Laptops', 'North', TO_DATE('2023-03-15', 'YYYY-MM-DD'), 3, 1399, 4197);
INSERT INTO electronics_sales_1 VALUES (14, 'Lenovo ThinkPad', 'Laptops', 'South', TO_DATE('2023-03-20', 'YYYY-MM-DD'), 5, 1199, 5995);
INSERT INTO electronics_sales_1 VALUES (15, 'Samsung Galaxy S22', 'Smartphones', 'East', TO_DATE('2023-03-25', 'YYYY-MM-DD'), 7, 749, 5243);
INSERT INTO electronics_sales_1 VALUES (16, 'Asus ROG Phone', 'Smartphones', 'West', TO_DATE('2023-04-05', 'YYYY-MM-DD'), 4, 899, 3596);
INSERT INTO electronics_sales_1 VALUES (17, 'Microsoft Surface', 'Laptops', 'North', TO_DATE('2023-04-10', 'YYYY-MM-DD'), 6, 1299, 7794);
INSERT INTO electronics_sales_1 VALUES (18, 'MacBook Air', 'Laptops', 'South', TO_DATE('2023-04-15', 'YYYY-MM-DD'), 8, 1199, 9592);
INSERT INTO electronics_sales_1 VALUES (19, 'Samsung Galaxy Tab A', 'Tablets', 'East', TO_DATE('2023-04-20', 'YYYY-MM-DD'), 10, 349, 3490);
INSERT INTO electronics_sales_1 VALUES (20, 'Amazon Fire', 'Tablets', 'West', TO_DATE('2023-04-25', 'YYYY-MM-DD'), 15, 149, 2235);



sql
SELECT 
    sale_id,
    product_name,
    category,
    region,
    sale_date,
    total_amount,
    LAG(total_amount) OVER (ORDER BY sale_date) AS previous_amount,
    LEAD(total_amount) OVER (ORDER BY sale_date) AS next_amount,
    CASE 
        WHEN total_amount > LAG(total_amount) OVER (ORDER BY sale_date) THEN 'HIGHER'
        WHEN total_amount < LAG(total_amount) OVER (ORDER BY sale_date) THEN 'LOWER'
        WHEN total_amount = LAG(total_amount) OVER (ORDER BY sale_date) THEN 'EQUAL'
        ELSE 'FIRST RECORD'
    END AS comparison_with_previous,
    CASE 
        WHEN total_amount > LEAD(total_amount) OVER (ORDER BY sale_date) THEN 'HIGHER'
        WHEN total_amount < LEAD(total_amount) OVER (ORDER BY sale_date) THEN 'LOWER'
        WHEN total_amount = LEAD(total_amount) OVER (ORDER BY sale_date) THEN 'EQUAL'
        ELSE 'LAST RECORD'
    END AS comparison_with_next
FROM 
    electronics_sales_1
ORDER BY 
    sale_date;



sql
SELECT 
    sale_id,
    product_name,
    category,
    total_amount,
    RANK() OVER (PARTITION BY category ORDER BY total_amount DESC) AS rank_in_category,
    DENSE_RANK() OVER (PARTITION BY category ORDER BY total_amount DESC) AS dense_rank_in_category
FROM 
    electronics_sales_1
ORDER BY 
    category, 
    total_amount DESC;




sql
WITH ranked_products AS (
    SELECT 
        sale_id,
        product_name,
        category,
        region,
        total_amount,
        DENSE_RANK() OVER (PARTITION BY category ORDER BY total_amount DESC) AS product_rank
    FROM 
        electronics_sales_1
)
SELECT 
    sale_id,
    product_name,
    category,
    region,
    total_amount,
    product_rank
FROM 
    ranked_products
WHERE 
    product_rank <= 3
ORDER BY 
    category, 
    product_rank;



sql
WITH ranked_sales AS (
    SELECT 
        sale_id,
        product_name,
        category,
        region,
        sale_date,
        total_amount,
        ROW_NUMBER() OVER (PARTITION BY region ORDER BY sale_date) AS sale_sequence
    FROM 
        electronics_sales_1
)
SELECT 
    sale_id,
    product_name,
    category,
    region,
    sale_date,
    total_amount,
    sale_sequence
FROM 
    ranked_sales
WHERE 
    sale_sequence <= 2
ORDER BY 
    region, 
    sale_date;




sql
SELECT 
    sale_id,
    product_name,
    category,
    region,
    total_amount,
    MAX(total_amount) OVER (PARTITION BY category) AS category_max_amount,
    MAX(total_amount) OVER () AS overall_max_amount,
    ROUND((total_amount / MAX(total_amount) OVER (PARTITION BY category)) * 100, 2) AS percent_of_category_max,
    ROUND((total_amount / MAX(total_amount) OVER ()) * 100, 2) AS percent_of_overall_max
FROM 
    electronics_sales_1
ORDER BY 
    category, 
    total_amount DESC;

