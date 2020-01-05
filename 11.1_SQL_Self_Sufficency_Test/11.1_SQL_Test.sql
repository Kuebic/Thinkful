-- 1. Inspect schema of naep table.
SELECT column_name, data_type 
FROM information_schema.columns
WHERE table_name = 'naep';

-- 2. Return first 50 records of naep table.
SELECT *
FROM naep
LIMIT 50;

-- 3. Return summary statistics for avg_math_4_score by state. 
-- Make sure to sort the results alphabetically by state name.
-- Summary stats: count, average, min, and max
SELECT 
	state,
	COUNT(avg_math_4_score) AS count_math_4, 
	ROUND(AVG(avg_math_4_score),3) AS avg_math_4, 
	MIN(avg_math_4_score) AS min_math_4,
	MAX(avg_math_4_score) AS max_math_4
FROM naep
GROUP BY state
ORDER BY state;

-- 4. Alter previous query so it returns only summary statistics for 
-- avg_math_4_score by state with differences in max and min values that are greater than 30.
SELECT 
	state,
	COUNT(avg_math_4_score) AS count_math_4, 
	ROUND(AVG(avg_math_4_score),3) AS avg_math_4, 
	MIN(avg_math_4_score) AS min_math_4,
	MAX(avg_math_4_score) AS max_math_4,
	MAX(avg_math_4_score) - MIN(avg_math_4_score) AS range_math_4
FROM naep
GROUP BY state
HAVING MAX(avg_math_4_score) - MIN(avg_math_4_score) >= 30
ORDER BY state;

--5. Return field called 'bottom_10_states' that lists bottom 10 states for avg_math_4_score in year 2000.
SELECT 
	state AS bottom_10_states, 
	avg_math_4_score --not necessary, but answers questions before they're asked
FROM naep
WHERE year = 2000
ORDER BY avg_math_4_score
LIMIT 10;

-- 6. Query that calculates average avg_math_4_score 
-- rounded to the nearest 2 decimal places 
-- over all states in the year 2000.
SELECT ROUND(AVG(avg_math_4_score),2) AS avg_math_4_score_y2000_all
FROM naep
WHERE year = 2000;

-- 7. Return a field called 'below_average_states_y2000' 
-- that lists all states with an avg_math_4_score less than the average over all states in the year 2000.
SELECT state AS below_average_states_y2000, avg_math_4_score
FROM naep
WHERE 
	year = 2000 AND
	avg_math_4_score <
		(SELECT AVG(avg_math_4_score)
		 FROM naep
		 WHERE year = 2000)
ORDER BY avg_math_4_score;

--8. Query that returns a field called 'scores_missing_y2000' that lists any states with missing 
-- values in the avg_math_4_score column of the naep data table for the year 2000.
SELECT state AS scores_missing_y2000
FROM naep
WHERE year = 2000 AND
	avg_math_4_score IS NULL;

-- 9. Query returns for year 2000 the state, avg_math_4_score, and total_expenditure 
-- from the naep table left outer joined with the finance table, 
-- using id as the key 
-- and ordered by total_expenditure greatest to least. 
-- Be sure to round avg_math_4_score to the nearest 2 decimal places, 
-- and then filter out NULL avg_math_4_scores in order to see any correlation more clearly.
SELECT 
	n.state, 
	ROUND(n.avg_math_4_score, 2) AS avg_math_4_score, 
	f.total_expenditure
FROM naep n LEFT OUTER JOIN finance f
	ON n.id = f.id
WHERE n.year = 2000
	AND avg_math_4_score IS NOT NULL
ORDER BY f.total_expenditure DESC;