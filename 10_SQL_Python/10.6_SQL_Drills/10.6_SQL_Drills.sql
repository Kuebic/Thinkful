-- 1. Draw a schema of the relationship between the people, salaries, 
-- 		and hof_inducted tables. There are several online database schema 
-- 		drawers that you can use for free, including draw.io, which we recommend. 
-- 		https://i.imgur.com/5rr7Z8m.png

-- 		1.a. Label the primary and foreign keys. (Note that a field can be a 
-- 			primary key to one table and a foreign key to another.)
--		ANSWER: primary and foreign keys:
--			- playerid
--			- yearid
--			- teamid
--			- lgid

-- 		1.b. What are the parent and child tables? Are these one-to-one, one-to-many, 
-- 			or many-to-many relationships?
--		ANSWER: The table peoples is the parent table, other two are child, with a one-to-many relationship.

-- 2. Write a query that returns the namefirst and namelast fields of the people table, 
-- 		along with the inducted field from the hof_inducted table. All rows from the people 
--		table should be returned, and NULL values for the fields from hof_inducted should be 
--		returned when there is no match found.

SELECT people.namefirst, people.namelast, hof_inducted.inducted
FROM people LEFT OUTER JOIN hof_inducted
ON people.playerid = hof_inducted.playerid;

-- 3. In 2006, a special Baseball Hall of Fame induction was conducted for players from 
-- 		the negro baseball leagues of the 20th century. In that induction, 17 players were 
--		posthumously inducted into the Baseball Hall of Fame. Write a query that returns the 
--		first and last names, birth and death dates, and birth countries for these players. 
--		Note that the year of induction was 2006, and the value for votedby will be “Negro League.”

SELECT p.namefirst, p.namelast, p.birthyear, p.deathyear, p.birthcountry
FROM people p LEFT OUTER JOIN hof_inducted hi
ON p.playerid = hi.playerid
WHERE hi.yearid = 2006
AND hi.votedby = 'Negro League';

-- 4. Write a query that returns the yearid, playerid, teamid, and salary fields from the salaries 
--		table, along with the category field from the hof_inducted table. Keep only the records 
--		that are in both salaries and hof_inducted. Hint: While a field named yearid is found in both 
--		tables, don’t JOIN by it. You must, however, explicitly name which field to include.

SELECT s.yearid, s.playerid, s.teamid, s.salary, hi.category
FROM salaries s JOIN hof_inducted hi
ON s.playerid = hi.playerid;

-- 5. Write a query that returns the playerid, yearid, teamid, lgid, and salary fields from the salaries 
--		table and the inducted field from the hof_inducted table. Keep all records from both tables.

SELECT s.playerid, s.yearid, s.teamid, s.lgid, s.salary, hi.inducted
FROM salaries s FULL OUTER JOIN hof_inducted hi
ON s.playerid = hi.playerid;

-- 6. There are 2 tables, hof_inducted and hof_not_inducted, indicating successful and unsuccessful 
--		inductions into the Baseball Hall of Fame, respectively.

	-- 6.a. Combine these 2 tables by all fields. Keep all records.
SELECT * FROM hof_not_inducted hni
UNION ALL
SELECT * FROM hof_inducted hi;

	-- 6.b. Get a distinct list of all player IDs for players who have been put up for HOF induction.
SELECT playerid FROM hof_not_inducted hni
UNION
SELECT playerid FROM hof_inducted hi;

-- 7. Write a query that returns the last name, first name (see people table), and total recorded 
--		salaries for all players found in the salaries table.
SELECT p.playerid, p.namefirst, p.namelast, SUM(s.salary)
FROM salaries s LEFT OUTER JOIN people p
ON s.playerid = p.playerid
GROUP BY p.playerid;

-- 8. Write a query that returns all records from the hof_inducted and hof_not_inducted tables 
--		that include playerid, yearid, namefirst, and namelast. 
--		Hint: Each FROM statement will include a LEFT OUTER JOIN!
SELECT hi.playerid, yearid, namefirst, namelast 
FROM hof_inducted hi LEFT OUTER JOIN people p
ON hi.playerid = p.playerid

UNION ALL 

SELECT hni.playerid, yearid, namefirst, namelast 
FROM hof_not_inducted hni LEFT OUTER JOIN people p
ON hni.playerid = p.playerid;

-- 9. Return a table including all records from both hof_inducted and hof_not_inducted, and 
--		include a new field, namefull, which is formatted as namelast , namefirst (in other words, 
--		the last name, followed by a comma, then a space, then the first name). The query should also 
--		return the yearid and inducted fields. Include only records since 1980 from both tables. Sort 
--		the resulting table by yearid, then inducted so that Y comes before N. Finally, sort by the 
--		namefull field, A to Z.

SELECT concat(namelast,', ', namefirst) AS namefull, yearid, inducted
FROM hof_inducted hi LEFT OUTER JOIN people p
ON hi.playerid = p.playerid
WHERE yearid >= 1980

UNION ALL 

SELECT concat(namelast,', ', namefirst) AS namefull, yearid, inducted
FROM hof_not_inducted hni LEFT OUTER JOIN people p
ON hni.playerid = p.playerid
WHERE yearid >= 1980

ORDER BY inducted DESC, namefull;

-- 10. Write a query that returns the highest annual salary for each teamid, ranked from high to low, 
--		along with the corresponding playerid. Bonus! Return namelast and namefirst in the resulting 
--		table. (You can find these in the people table.)

WITH max AS
	(SELECT MAX(salary) as max_salary, teamid, yearid
	FROM salaries s
	GROUP BY teamid, yearid)
SELECT s.yearid, s.teamid, p.playerid, concat(p.namelast,', ', p.namefirst) AS namefull, max.max_salary
FROM max LEFT OUTER JOIN salaries s
ON s.teamid = max.teamid AND s.yearid = max.yearid AND s.salary = max.max_salary
LEFT OUTER JOIN people p
ON s.playerid = p.playerid
ORDER BY max.max_salary DESC;

-- 11. Select birthyear, deathyear, namefirst, and namelast of all the players born since the birth year 
--		of Babe Ruth (playerid = ruthba01). Sort the results by birth year from low to high.
SELECT birthyear, deathyear, namefirst, namelast
FROM people
WHERE birthyear > ANY
	(SELECT	birthyear
	FROM people
	WHERE playerid = 'ruthba01')
ORDER BY birthyear;

-- 12. Using the people table, write a query that returns namefirst, namelast, and a field called usaborn 
--		where. The usaborn field should show the following: if the player's birthcountry is the USA, then 
--		the record is 'USA.' Otherwise, it's 'non-USA.' Order the results by 'non-USA' records first.
SELECT namefirst, namelast, 
	CASE
		WHEN birthcountry = 'USA' THEN 'USA'
		ELSE 'non-USA'
	END AS usaborn
FROM people
ORDER BY 3;

-- 13. Calculate the average height for players throwing with their right hand versus their left hand. 
--		Name these fields right_height and left_height, respectively.
SELECT
AVG(CASE WHEN throws = 'R' THEN height END) AS right_height,
AVG(CASE WHEN throws = 'L' THEN height END) AS left_height
FROM people;

-- 14. Get the average of each team's maximum player salary since 2010. Hint: WHERE will go inside your CTE.
WITH max_sal_by_team_by_year AS
	(SELECT teamid, yearid, MAX(salary) AS max_sal
	FROM salaries
	GROUP BY teamid, yearid)
SELECT teamid, AVG(max_sal) AS avg_max_sal_since_2010
FROM max_sal_by_team_by_year
WHERE yearid > 2010
GROUP BY teamid;

