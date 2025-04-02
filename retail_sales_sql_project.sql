DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales

   (
         transactions_id INT PRIMARY KEY,
		 sale_date	DATE,
		 sale_time TIME,
		 customer_id INT,
		 gender	VARCHAR(15),
		 age INT,
		 category VARCHAR(15),
		 quantiy INT,	
		 price_per_unit FLOAT,
		 cogs FLOAT,
		 total_sale FLOAT
   )   
SELECT * FROM retail_sales;
SELECT COUNT(*) FROM retail_sales;

--SELECT NULL VALUES--

SELECT * FROM retail_sales
WHERE
     transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR 
	 sale_time IS NULL
	 OR
	 gender IS NULL
	 OR
	 category IS NULL
	 OR
	 quantiy IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL
	 
-- DELETE NULL VALUES --	 

DELETE FROM retail_sales
WHERE
     transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR 
	 sale_time IS NULL
	 OR
	 gender IS NULL
	 OR
	 category IS NULL
	 OR
	 quantiy IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL

---DATA EXPLORATION---

---HOW MANY SALES WE HAVE?

SELECT COUNT(*) AS total_sales FROM retail_sales

--HOW MANY UNIQUE CUSTOMERS WE HAVE?

SELECT COUNT(DISTINCT customer_id) AS total_customers FROM retail_sales

--HOW MANY UNIQUE CATEGORIES WE HAVE?

SELECT COUNT(DISTINCT category) AS total_categories FROM retail_sales



----DATA ANALYSIS AND BUSINESS KEY PROBLEMS AND ANSWERS---

--WRITE A SQL QUERY TO RETRIEVE ALL COLUMNS FOR SALES MADE ON 2022-11-05 ?
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05'

--WRITE SQL QUERY TO RETRIEVE ALL TRANSACTIONS WHERE THE CATEGORY IS CLOTHING AND QUANTITY SOLD IS
--MORE THAN 4 IN THE MONTH OF NOV-2022

SELECT * 
FROM retail_sales
WHERE 
     category = 'Clothing'
     AND 
     TO_CHAR(sale_date, 'YYYY-MM')='2022-11'
	 AND
	 quantiy>=4

---WRITE SQL QUERY TO TO CALCULATE THE TOATAL SALES FOR EACH CATEGORY ?

SELECT category,SUM(total_sale) AS total_sales FROM retail_sales
GROUP BY category

---WRITE SQL QUERY TO FIND AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM BEAUTY CATEGORY ?

SELECT ROUND(AVG(age),2) AS avg_age FROM retail_sales 
WHERE category='Beauty'

---WRITE SQL QUERY TO FIND ALL TRANSACTIONS WHERE TOTAL_SALES IS GREATER THAN 1000 ?

SELECT * FROM retail_sales 
WHERE total_sale>1000

---WRITE SQL QUERY TO FIND TOATAL NUMBER OF TRANSACTIONS MADE BY EACH GENDER IN EACH CATEGORY ?

SELECT category,gender,COUNT(transactions_id) FROM retail_sales 
GROUP BY category, gender

--WRITE SQL QUERY TO CALCULATE AVERAGE SALE FOR MONTH.FIND OUT BEST SELLING MONTH IN EACH YEAR ?

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
WHERE rank=1

---WRITE SQL QUERY TO FIND TOP 5 CUSTOMERS BASED ON  HIGHEST TOTAL SALES ?

SELECT customer_id,SUM(total_sale) as total_sales FROM  retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5

---WRITE SQL QUERY TO find number of unique customers who purchased items from each category ?

SELECT category,COUNT(DISTINCT customer_id) as count
FROM retail_sales
GROUP BY category

---WRITE SQL QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS (MORNING <=12,AFTERNOON BETWEEN 12 & 17 ,EVENING>17)

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
GROUP BY shift