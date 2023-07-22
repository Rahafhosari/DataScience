--Question 1: Set 1 Q1 MODIFIED
SELECT c.name,
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
GROUP BY c.name
ORDER BY 1;

--Modification:
--In order for the query to match the results set I removed the film title from the selected Data,
--so the reulst will yeild in catgories and rental count of films in that category.

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

--Question 4: Set 2 Q1 MODIFIED
WITH rental_month_year as 
(
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
    GROUP BY store.store_id, rental_month, rental_year
)
SELECT  
    rental_month,
    rental_year,
    store_id,
    count_rentals
FROM rental_month_year 
ORDER BY count_rentals DESC, rental_month_year.rental_year ASC;

--Modification:
--Created an CTE to capture the rental_date partition of month and year
--Then used this to select the required data from the CTE.