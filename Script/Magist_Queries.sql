/*All products orders*/
SELECT order_id, COUNT(*)
FROM orders;

/*Tech products orders, tech products divercity*/
SELECT 
	e.product_category_name_english,
    COUNT(ord.order_id) AS order_pro_category, COUNT(DISTINCT p.product_id) AS products
from product_category_name_translation e
join products p
using(product_category_name)
join order_items ord
using(product_id)
WHERE e.product_category_name_english IN('computers_accessories', 'telephony', 'computers', 'electronics', 'computers_accessories', 'telephony')
GROUP BY e.product_category_name_english
order by order_pro_category desc;


/*All products divercity*/
SELECT COUNT(DISTINCT product_id) AS 'number of products'
FROM products;

/*Tech products*/

/*Users yearly growth*/
SELECT YEAR(order_purchase_timestamp), COUNT(order_id)
FROM orders
GROUP BY YEAR(order_purchase_timestamp);

/*Tech products users yearly growth*/
SELECT 
	e.product_category_name_english,
     YEAR(o.order_purchase_timestamp), COUNT(o.order_id)
from product_category_name_translation e
join products p
using(product_category_name)
join order_items ord
using(product_id)
join orders o
using (order_id)
WHERE e.product_category_name_english IN('computers_accessories', 'telephony', 'computers', 'electronics', 'computers_accessories', 'telephony')
GROUP BY /*e.product_category_name_english,*/ YEAR(order_purchase_timestamp);

/*Avg all products price*/
SELECT ROUND(AVG(price), 2) 
FROM order_items;

/*Avg tech product price*/
SELECT ROUND(AVG(price), 2) 
FROM order_items
JOIN products
USING(product_id)
JOIN product_category_name_translation e
USING(product_category_name)
WHERE e.product_category_name_english IN('computers_accessories', 'telephony', 'computers', 'electronics', 'computers_accessories', 'telephony');

/*Tech products price catageroies*/
SELECT COUNT(price),
 CASE
    WHEN price >= 1000 THEN 'expensive'
	WHEN price >= 500 THEN 'medium'
	ELSE 'cheap'
END AS PRICE_LEVEL
FROM order_items 
LEFT JOIN products
USING(product_id)
LEFT JOIN product_category_name_translation e
USING(product_category_name)
WHERE e.product_category_name_english IN('computers_accessories', 'telephony', 'computers', 'electronics', 'computers_accessories', 'telephony')
GROUP BY PRICE_LEVEL;



/*PRACH/Price category of tech product*/

SELECT COUNT(oi.product_id) as products_count, 
	CASE 
		WHEN price > 1000 THEN "Expensive"
		WHEN price > 100 THEN "Mid-Ranged"
		ELSE "Cheap"
	END AS "price_range"
FROM order_items oi
LEFT JOIN products p
	ON p.product_id = oi.product_id
LEFT JOIN product_category_name_translation pt
	USING (product_category_name)
WHERE pt.product_category_name_english IN ("watches_gifts", "electronics", "computers_accessories", "pc_gamer", "computers", "consoles_games", "telephony")
GROUP BY price_range;

/*PRACH/General number of sellers*/
SELECT COUNT(*) FROM sellers;

/*PRACH/Number of tech products sellers*/
SELECT COUNT(DISTINCT s.seller_id) as tech_sellers
FROM sellers s
INNER JOIN order_items oi ON s.seller_id = oi.seller_id
INNER JOIN products p ON oi.product_id = p.product_id
INNER JOIN product_category_name_translation pt ON p.product_category_name = pt.product_category_name
WHERE pt.product_category_name_english IN ('electronics','computers_accessories','pc_gamer','computers','consoles_games','telephony','watches_gifts');

/*Tech producs customers reviews*/
SELECT COUNT(review_score),
 CASE
    WHEN review_score = 5 THEN 'excelent'
	WHEN review_score >= 3 THEN 'medium'
	ELSE 'unsatisfied'
END AS REVIEWS

FROM order_reviews
JOIN order_payments
USING(order_id)
JOIN orders
USING(order_id)
JOIN order_items
USING(order_id)
JOIN products
USING(product_id)
JOIN product_category_name_translation e
USING(product_category_name)

WHERE e.product_category_name_english IN('computers_accessories', 'telephony', 'computers', 'electronics', 'computers_accessories', 'telephony')
GROUP BY REVIEWS;