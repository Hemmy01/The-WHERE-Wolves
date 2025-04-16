## NAME: ##
-- member-1:
-- member-2:

# SQL Window Functions Assignment

## Overview
This repository contains a comprehensive solution for the SQL Window Functions assignment (pages 26-31). The project demonstrates practical applications of window functions including LAG(), LEAD(), RANK(), DENSE_RANK(), ROW_NUMBER(), and various aggregate functions on an electronics retail company dataset.

## Dataset
The project uses a custom electronics sales dataset that includes:
- Sale ID
- Product name
- Category
- Region
- Sale date
- Quantity
- Unit price
- Total amount

## Features Implemented

### 1. Value Comparison with Previous/Next Records
- Used LAG() and LEAD() functions to compare current sales amounts with previous and next records
- Implemented conditional logic to determine if values are higher, lower, or equal
- Provides chronological analysis of sales performance

### 2. Category-Based Ranking
- Applied both RANK() and DENSE_RANK() to rank products within categories
- Demonstrates the difference between these ranking functions when handling ties
- Helps identify top performers within each product category

### 3. Top Records Identification
- Created queries to fetch top 3 products with highest sales in each category
- Used Common Table Expressions (CTE) with DENSE_RANK() to properly handle potential ties
- Provides focused view of best-selling products by category

### 4. Earliest Records Analysis
- Implemented ROW_NUMBER() to identify the first 2 sales transactions from each region
- Ordered by sale date to maintain chronological sequence
- Useful for analyzing initial sales patterns by region

### 5. Multi-level Aggregation
- Calculated both category-specific maximums and overall maximum total amounts
- Implemented percentage calculations to show how each sale compares to category and global maximums
- Provides context for individual sales performance

## Real-Life Applications
The repository includes discussion of practical business applications for window functions:
- Sales performance analysis
- Financial analysis
- Customer behavior analysis
- Supply chain management
- Human resources analytics

## Screenshots
Screenshots of query results can be found in the [screenshots](/screenshots) folder.

## Installation and Setup
1. Create the electronics_sales_1 table using the provided SQL script
2. Insert the sample data
3. Run the individual query examples to see window functions in action

## Technologies Used
- Oracle SQL
- SQL Window Functions
- Common Table Expressions (CTE)

## Future Improvements
- Add more complex partitioning examples
- Implement rolling averages and running totals
- Expand dataset with more variables for deeper analysis