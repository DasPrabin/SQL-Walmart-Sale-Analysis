Create Database if not Exists Walmart;
use Walmart;

-- Rename the Table Name.
ALTER table walmartsalesdata
Rename TO walmart;

--  
Select * From walmart;
-- ------------------------------------------------------------------------------------------------------------------------------;
-- -------------------------------------------------------------------------------------------------------------------------------;
-- TIME OF DAY
SELECT Time,
   (CASE 
      WHEN `Time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
      WHEN `Time` BETWEEN "12:01:00" AND  "16:00:00" THEN "AfterNoon"
       ELSE "Evening"
       END ) as Time_of_Day
       FROM Walmart;
       
       
       ALTER TABLE walmart  
       ADD COLUMN Time_of_dau varchar(20);
       
       ALter table walmart
       Rename Column Time_of_dau to Time_Of_Day;
       
       UPDATE walmart
       SET Time_of_day =
       (CASE 
            WHEN `Time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
            WHEN `Time` BETWEEN "12:01:00" AND  "16:00:00" THEN "AfterNoon"
             ELSE "Evening"       
       END 
       );
       
-- -------------------------------DAY NAME ---------------------------------------------------------------------------
Alter Table Walmart
Add column Dt date;
    
UPDATE Walmart 
SET dt = 
DATE_ADD('1899-12-30', INTERVAL dates DAY) 
WHERE dates 
REGEXP '^[0-9]+$';

UPDATE walmart 
SET dates = dt
 WHERE dates REGEXP '^[0-9]+$';

ALTER Table walmart
Drop column dt;

ALTER TABLE walmart
RENAME COLUMN dates to Date;

UPDATE walmart SET date = STR_TO_DATE(date, '%d-%m-%Y') 
WHERE date 
REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$';

SELECT
Date,DAYNAME(Date) as day_name
FROM walmart;
 
 ALTER TABLE walmart
 ADD COLUMN day_name varchar(10);
 
 UPDATE walmart
 SET day_name = (DAYNAME(Date));
 
 -- ------------------Month Name ------------------------------------------------------------------------------
 SELECT 
 Date,MONTHNAME(Date) AS month_name
 FROM walmart;
 
 ALTER TABLE walmart
 ADD COLUMN month_name varchar(20);
 
 UPDATE walmart
 SET month_name = (MONTHNAME(Date));
 -- ----------------------------------------------------------------------------------------------------------------------------------
-- How many unique city does the data have.

SELECT DISTINCT City
FROM walmart;

-- How many Unique Product line the data have;
SELECT  
COUNT(DISTINCT Product_line) 
AS Uniqe_PL
FROM walmart ;

-- what is the most common payment methose;
SELECT 
Payment, 
count(Payment) as cnt
FROM walmart
GROUP BY Payment 
ORDER BY cnt desc;

-- What is the most selling product line?

SELECT
Product_line,
COUNT(Product_line) AS TotalQTY
FROM walmart
GROUP BY product_line
ORDER BY TotalQTY DESC LIMIT 1 ;

-- What is the second most selling product line?

SELECT
Product_line,
COUNT(Total) AS TotalQTY
FROM walmart
GROUP BY product_line
ORDER BY TotalQTY DESC LIMIT 1 OFFSET 1;

-- What is the total revenue by month?
SELECT month_name,
SUM(Total) AS Total_sale
 FROM walmart
 GROUP BY month_name;
 -- What month had the largest COGS?
-- What product line had the largest revenue?

SELECT Product_line,
SUM(Total) AS Total_revenew
FROM walmart
GROUP BY Product_line
ORDER BY Total_revenew DESC LIMIT 1;

-- What is the city with the largest revenue?

SELECT City,
SUM(Total) AS Total_revenew
FROM walmart
GROUP BY City
ORDER BY Total_revenew DESC LIMIT 1;

-- What product line had the largest VAT?
-- What product line had the largest revenue?

SELECT Product_line,
SUM(Total) AS Total_revenew
FROM walmart
GROUP BY Product_line
ORDER BY Total_revenew DESC LIMIT 1;

-- What is the city with the largest revenue?

SELECT City,
SUM(Total) AS Total_revenew
FROM walmart
GROUP BY City
ORDER BY Total_revenew DESC LIMIT 1;

-- What product line had the largest VAT?
SELECT Product_line,
AVG(`Tax5%`) AS VAT
FROM walmart
GROUP BY Product_line
ORDER BY VAT DESC ;

-- Which branch sold more products than average product sold?
SELECT Branch,
SUM(Quantity) AS total_qty
FROM walmart
GROUP BY Branch
HAVING total_qty > (SELECT 
AVG(Quantity) 
FROM walmart);

-- What is the most common product line by gender?
SELECT Gender,Product_line,
COUNT(Gender) AS Totalcnt
FROM walmart 
GROUP BY Gender,Product_line
ORDER BY Totalcnt;

-- What is the average rating of each product line?

SELECT Product_line,
ROUND(AVG(Rating),2) AS AvgRating
FROM walmart
GROUP BY Product_line
ORDER BY AvgRating DESC;

-- Number of sales made in each time of the day per weekday

SELECT 
Time_of_day,
Count(Invoice_id) AS Total_sales
FROM walmart
WHERE day_name = "friday"
GROUP BY time_of_day
ORDER BY total_sales DESC;

-- Which of the customer types brings the most revenue?

SELECT Customer_type,
SUM(Total) AS most_revenew
FROM walmart
GROUP BY Customer_type
ORDER BY most_revenew DESC;

-- Which city has the largest tax percent/ VAT (Value Added Tax)?

SELECT city,
ROUND(AVG(`Tax5%`*cogs),2) AS VAT
FROM walmart
GROUP BY city
ORDER BY VAT DESC;

-- Which customer type pays the most in VAT?

SELECT Customer_type,
ROUND(AVG(`Tax5%`*cogs),2) AS VAT
FROM walmart
GROUP BY Customer_type
ORDER BY VAT DESC;

-- How many unique customer types does the data have?

SELECT count(DISTINCT Customer_type)
FROM walmart;

-- How many unique payment methods does the data have?

SELECT count(DISTINCT Payment)
FROM walmart;

-- What is the most common customer type?
SELECT Customer_type,
count(Invoice_id) AS most_common
FROM walmart
GROUP BY Customer_type
ORDER BY most_common Desc;

--  customer type buys the most?
SELECT Customer_type,
COUNT(*) AS most_buyCX
FROM walmart
GROUP BY Customer_type
ORDER BY most_buyCX Desc;

-- What is the gender of most of the customers?

SELECT Gender,
COUNT(Invoice_id) AS most_gender
FROM walmart
GROUP BY Gender
ORDER BY most_gender Desc;

-- What is the gender distribution per branch?
SELECT Branch,Gender,
COUNT(Gender) As gender_cnt
FROM walmart
GROUP BY Branch,Gender
ORDER BY Branch ;

-- Which time of the day do customers give most ratings?

SELECT Time_Of_Day,
ROUND(AVG(Rating),2) AS most_ratingCnt
FROM walmart
GROUP BY Time_Of_Day
ORDER BY most_ratingCnt DESC;

-- Which time of the day do customers give most ratings per branch?
 SELECT Branch,Time_Of_Day,
 ROUND(AVG(Rating),2) AS most_rating
 FROM walmart
 GROUP BY Time_Of_Day,Branch
 ORDER BY Branch;

-- Which day 0f the week has the best avg ratings?
SELECT day_name,
ROUND(AVG(Rating),2) AS Avg_Rating
FROM walmart
GROUP BY day_name
ORDER BY Avg_Rating DESC;

-- Which day of the week has the best average ratings per branch?
SELECT branch,day_name,
ROUND(AVG(RATING),2) AS avg_Rating
FROM walmart
GROUP BY branch,day_name
ORDER BY avg_Rating DESC;
