--Get the name and data type from every field in the 
--"film" table
SELECT column_name, data_type 
FROM information_schema.columns
WHERE table_name = 'film';

--Select first 100 records from the "film" table
SELECT *
FROM film
LIMIT 100;