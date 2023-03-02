/*

More advanced SQL

------------------------------------------------------------------------------------------------

HOW TO GET THE SCHEMA OF A DATABASE: 
* Windows/Linux: Ctrl + r
* MacOS: Cmd + r

*/

/**************************
***************************
CHALLENGES
***************************
**************************/

-- In SQL we can have many databases, they will show up in the schemas list
-- We must first define which database we will be working with
USE publications; 
 
/**************************
ALIAS
**************************/
-- https://www.w3schools.com/sql/sql_alias.asp

-- 1. From the sales table, change the column name qty to Quantity
SELECT *, qty AS 'Quantity'
FROM sales;

-- 2. Assign a new name into the table sales. Select the column order number using the table alias
SELECT a.ord_num
FROM sales AS a;
/**************************
JOINS
**************************/
-- https://www.w3schools.com/sql/sql_join.asp

/* We will only use LEFT, RIGHT, and INNER joins this week
You do not need to worry about the other types for now */

-- LEFT JOIN example
-- https://www.w3schools.com/sql/sql_join_left.asp
SELECT *
FROM stores s
LEFT JOIN discounts d 
ON d.stor_id = s.stor_id;

-- RIGHT JOIN example
-- https://www.w3schools.com/sql/sql_join_right.asp
SELECT *
FROM stores s
RIGHT JOIN discounts d
ON d.stor_id = s.stor_id;

-- INNER JOIN example
-- https://www.w3schools.com/sql/sql_join_inner.asp
SELECT *
FROM stores s
INNER JOIN discounts d 
ON d.stor_id = s.stor_id;

-- 3. Using LEFT JOIN: in which cities has "Is Anger the Enemy?" been sold?
-- HINT: you can add WHERE function after the joins
SELECT *
FROM titles t
LEFT JOIN sales s
ON t.title_id = s.stor_id
WHERE title = "Is Anger the Enemy?";

-- 4. Using RIGHT JOIN: select all the books (and show their titles) that have a link to the employee Howard Snyder.
SELECT authorstitle
FROM titles
RIGHT JOIN employee
USING(pub_id)
WHERE fname = 'Howard' AND lname = 'Snyder';
 
-- 5. Using INNER JOIN: select all the authors that have a link (directly or indirectly) with the employee Howard Snyder
SELECT a.au_fname, a.au_lname, e.fname, e.lname
FROM authors a
JOIN titleauthor ti
ON a.au_id = ti.au_id
JOIN titles ts
ON ti.title_id = ts.title_id
JOIN publishers
USING(pub_id)
JOIN employee e
USING(pub_id)
WHERE fname = 'Howard' AND lname = 'Snyder';
-- 6. Using the JOIN of your choice: Select the book title with higher number of sales (qty)
SELECT t.title, SUM(qty)
FROM sales
JOIN titles t
USING(title_id)
GROUP BY 1
ORDER BY SUM(qty)
LIMIT 1;
/*****title_id*********************
CASE
**************************/
-- https://www.w3schools.com/sql/sql_case.asp

-- 7. Select everything from the sales table and create a new column called "sales_category" with case conditions to categorise qty
--  * qty >= 50 high sales
--  * 20 <= qty < 50 medium sales
--  * qty < 20 low sales
SELECT *,
  CASE
    WHEN qty >= 50 THEN 'high sales'
    WHEN qty < 50 AND qty >= 20 THEN 'medium sales'
    ELSE 'low sales'
  END AS sales_category
FROM sales;

-- 8. Adding to your answer from question 7. Find out the total amount of books sold (qty) in each sales category
-- i.e. How many books had high sales, how many had medium sales, and how many had low sales
SELECT *, SUM(qty),
  CASE
    WHEN qty >= 50 THEN 'high sales'
    WHEN qty < 50 AND qty >= 20 THEN 'medium sales'
    ELSE 'low sales'
  END AS sales_category
FROM sales
GROUP BY sales_category;

-- 9. Adding to your answer from question 8. Output only those sales categories that have a SUM(qty) greater than 100, and order them in descending order
SELECT *, SUM(qty),
  CASE
    WHEN qty >= 50 THEN 'high sales'
    WHEN qty < 50 AND qty >= 20 THEN 'medium sales'
    ELSE 'low sales'
  END AS sales_category
FROM sales
GROUP BY sales_category
HAVING SUM(qty) >100;

-- 10. Find out the average book price, per publisher, for the following book types and price categories:
-- book types: business, traditional cook and psychology
-- price categories: <= 5 super low, <= 10 low, <= 15 medium, > 15 high
SELECT pub_id, type, AVG(price),
  CASE
    WHEN price <= 5 THEN 'super low'
    WHEN price <= 10 THEN 'low'
    WHEN price <= 15 THEN 'medium'
    ELSE 'high'
  END AS sales_price
FROM titles
WHERE type IN('business', 'traditional cook', 'psychology')
GROUP BY pub_id;
