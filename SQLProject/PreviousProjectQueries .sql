--Question 1: Set 1 Q1
--Create a query that lists each movie, the film category it is classified in, and the number of times it has been rented out.
SELECT f.title,
	   c.name,
	COUNT(r.rental_id) AS rental_count
FROM film_category fc
JOIN film f
ON f.film_id = fc.film_id
JOIN category c
ON c.category_id = fc.category_id
JOIN inventory i
ON i.film_id = f.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id
WHERE c.name IN ('Animation','Children','Classics','Comedy','Family','Music')
GROUP BY f.title, c.name
ORDER BY 2;

--Notes:
-- Filter Categories to the Family-friendly categories mentioned
-- GROUP BY title and name to group the counts for the rental 
-- To sort the movies Alphabetically order by DESC the category name

--Question 2: Set 1 Q2
SELECT f.title AS title,
    c.name AS name,
    f.rental_duration,
    NTILE(4) OVER (ORDER BY  AVG(f.rental_duration)) AS quartile                                                
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON c.category_id = fc.category_id
WHERE c.name IN ('Animation','Children','Classics','Comedy','Family','Music')
GROUP BY f.title, c.name,f.rental_duration
ORDER BY quartile; 

--Notes: 
--Create the quartile using the PERCINTILE

--Question 3: Set 1 Q3
SELECT 
    name,
    standard_quartile,
    COUNT(*) AS count
FROM (
    SELECT
        c.name AS name,
        NTILE(4) OVER (ORDER BY  AVG(f.rental_duration)) AS standard_quartile                                             
    FROM film f
    JOIN film_category fc
    ON f.film_id = fc.film_id
    JOIN category c
    ON c.category_id = fc.category_id
    WHERE c.name IN ('Animation','Children','Classics','Comedy','Family','Music')
    GROUP BY f.title, c.name
) AS subquery
GROUP BY name, standard_quartile
ORDER BY name, standard_quartile;

--Notes:
--Select the category names and quartile for each category as asubquery
--then we do the count of all rows appearing
--Grouping them by the quartile and category name 
--and ordering them to get Alphabatical order and numbers of quartile from 1 to 4 for each category

--Question 4: Set 2 Q1
SELECT  
    DATE_PART('month', r.rental_date) AS rental_month,
    DATE_PART('year', r.rental_date) AS rental_year,
    store.store_id,
    COUNT(r.rental_id) as count_rentals
FROM rental r
JOIN payment p
ON p.rental_id = r.rental_id
JOIN staff 
ON staff.staff_id = r.staff_id
JOIN store 
ON store.store_id = staff.store_id
GROUP BY store.store_id,rental_month,rental_year
ORDER BY count_rentals DESC, rental_year ASC;

--Notes:
--Part Rental Date by month and Year and show them as columns
--order bye count rentals descenfdingly from largest to smallest 
--and by years ascendingly to start from previous years to latest
