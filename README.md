
**Retail Sales Analysis SQL Project**

**Project Overview**

This project involves analyzing retail sales data using SQL. The dataset contains 2000 rows and includes key attributes such as transaction ID, sale date, sale time, customer demographics, product categories, and sales figures. The goal of this project is to perform data exploration, cleaning, and analysis to derive meaningful business insights.

**Objectives**

Create and manage a retail sales database.

Perform data cleaning by identifying and removing NULL values.

Conduct data exploration to understand key metrics like total sales, unique customers, and category-wise distribution.

Execute business-related queries to uncover patterns in sales performance, customer demographics, and transaction trends.

**Project Structure**

**Database Creation & Setup**

Create the retail_sales table.

Define primary keys and data types.

Insert and validate data.

Data Cleaning

Identify NULL values.

Delete NULL values to ensure data integrity.

Data Exploration

1. **HOW MANY SALES WE HAVE?**
   '''sql
   SELECT COUNT(*) AS total_sales
   FROM retail_sales;
   '''

2. **HOW MANY UNIQUE CUSTOMERS WE HAVE?**
   '''sql
   SELECT COUNT(DISTINCT customer_id)
   AS total_customers FROM retail_sales;
   '''

3. **WRITE A SQL QUERY TO RETRIEVE ALL COLUMNS FOR SALES MADE ON 2022-11-05 ?**
   '''sql
   SELECT * FROM retail_sales
   WHERE sale_date = '2022-11-05';
   '''

4. **WRITE SQL QUERY TO RETRIEVE ALL TRANSACTIONS WHERE THE CATEGORY IS CLOTHING AND QUANTITY SOLD IS
     MORE THAN 4 IN THE MONTH OF NOV-2022**
   '''sql
   SELECT * 
FROM retail_sales
WHERE 
     category = 'Clothing'
     AND 
     TO_CHAR(sale_date, 'YYYY-MM')='2022-11'
     AND
     quantiy>=4;
   
    '''
5. **WRITE SQL QUERY TO TO CALCULATE THE TOATAL SALES FOR EACH CATEGORY ?**
   '''sql
   SELECT category,SUM(total_sale)
   AS total_sales FROM retail_sales
   GROUP BY category;
   '''

6. **WRITE SQL QUERY TO FIND AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM BEAUTY CATEGORY ?**
   '''sql
   SELECT ROUND(AVG(age),2)
   AS avg_age FROM retail_sales 
   WHERE category='Beauty';
   '''
7. **WRITE SQL QUERY TO FIND ALL TRANSACTIONS WHERE TOTAL_SALES IS GREATER THAN 1000 ?**
   '''sql
   SELECT * FROM retail_sales 
   WHERE total_sale>1000;
   '''

8. **WRITE SQL QUERY TO FIND TOATAL NUMBER OF TRANSACTIONS MADE BY EACH GENDER IN EACH CATEGORY ?**
   '''sql
   SELECT category,gender,COUNT(transactions_id)
   FROM retail_sales 
   GROUP BY category, gender;
   '''

9. **WRITE SQL QUERY TO CALCULATE AVERAGE SALE FOR MONTH.FIND OUT BEST SELLING MONTH IN EACH YEAR ?**
    '''sql
   SELECT * FROM
        (
        SELECT
        EXTRACT(YEAR FROM sale_date) as year,
        EXTRACT(MONTH FROM sale_date) as month,
        AVG(total_sale) as avg_sales,
        RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale)DESC)AS rank
        FROM retail_sales
        GROUP BY month,year
        )AS t1
   WHERE rank=1;
   '''

11. **WRITE SQL QUERY TO FIND TOP 5 CUSTOMERS BASED ON  HIGHEST TOTAL SALES ?**
    '''sql
    SELECT customer_id,SUM(total_sale) as total_sales FROM  retail_sales
    GROUP BY customer_id
    ORDER BY total_sales DESC
    LIMIT 5;
    '''

12. **WRITE SQL QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS (MORNING <=12,AFTERNOON BETWEEN 12 & 17 ,EVENING>17)**
    '''sql
   WITH hourly_sale AS
(
SELECT * ,
     CASE
	 WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
	 WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	 ELSE 'Evening'
	 END AS shift

FROM retail_sales
)
SELECT shift,COUNT(*)AS total_orders
FROM hourly_sale
GROUP BY shift;
'''
                                        
                        
                        
