/*Tutorial 0 */
1
  SELECT population FROM world
  WHERE name = 'Germany'
2
  SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark');
3
  SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000

/*Tutorial 1 */
1
SELECT name, continent, population FROM world
2
SELECT name FROM world
WHERE population >= 200000000
3
SELECT name, gdp/population AS "per capita GDP"
FROM world
WHERE population >= 200000000
4
SELECT name, population/1000000 AS 'Population in Millions'
FROM world
WHERE continent LIKE 'South America'
5
SELECT name, population
FROM world
WHERE name IN ('France', 'Germany', 'Italy')
6
SELECT name
FROM world
WHERE name LIKE '%United%'
7
SELECT name, population, area
FROM world
WHERE area > 3000000 
OR population > 250000000
8
SELECT name, population, area
FROM world
WHERE area > 3000000 
XOR population > 250000000
9
SELECT name, ROUND(population / 1000000, 2) AS "Population in millions", ROUND(GDP / 1000000000, 2) AS "GDP in billions"
FROM world
WHERE continent LIKE 'South America' 
10
SELECT name, ROUND(GDP / population,-3) AS "per-capita GDP"
FROM world
WHERE GDP >= 1000000000000
11
SELECT name, capital
FROM world
WHERE LENGTH(name) = LENGTH(capital)
12
SELECT name, capital
FROM world
WHERE name != capital
AND LEFT(name,1) = LEFT(capital,1)
13
SELECT name
FROM world
WHERE name LIKE '%a%' 
 AND name LIKE '%e%' 
 AND name LIKE '%i%' 
 AND name LIKE '%o%'
 AND name LIKE '%u%'
 AND name NOT LIKE '% %'
 /*Tutorial 2 */
 1
 SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950
 2
 SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature'
 3
SELECT yr, subject
FROM nobel
WHERE winner LIKE 'Albert Einstein'
4
SELECT winner
FROM nobel
WHERE subject LIKE 'Peace'
AND yr >= 2000
5.
SELECT yr, subject, winner
FROM nobel
WHERE subject LIKE 'Literature'
AND yr >= 1980 
AND yr <= 1989
6.
SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt',
                   'Woodrow Wilson',
                   'Jimmy Carter',
                   'Barack Obama'
                 )
7. 
SELECT winner FROM nobel
WHERE winner LIKE 'John%'
8.
SELECT * FROM nobel
WHERE subject LIKE 'Physics' 
AND yr = 1980
OR subject LIKE 'Chemistry' 
AND yr = 1984
9.
SELECT * FROM nobel
WHERE subject NOT IN ('Chemistry', 'Medicine')
AND yr = 1980
10.
SELECT * FROM nobel
WHERE subject LIKE 'Medicine'
AND yr < 1910
OR subject LIKE 'Literature'
AND yr >= 2004
11.
SELECT * FROM nobel
WHERE winner LIKE 'PETER GR%NBERG'
12.
SELECT * FROM nobel
WHERE winner LIKE 'EUGENE O''NEILL'
13.
SELECT winner, yr, subject FROM nobel 
WHERE winner Like 'Sir%' 
ORDER BY yr DESC,winner
14.
SELECT winner, subject
  FROM nobel
 WHERE yr=1984
 ORDER BY subject IN ('Physics', 'Chemistry'),subject, winner
/*Tutorial 3 */
1. 
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')
2.
SELECT name FROM world
WHERE (gdp / population) >
  (SELECT (gdp / population) FROM world
   WHERE name LIKE 'United Kingdom')
AND continent LIKE 'Europe'
3.
SELECT name, continent FROM world
WHERE continent LIKE (SELECT continent FROM world
      WHERE name='Argentina') 
OR continent LIKE (SELECT continent FROM world
      WHERE name='Australia') 
ORDER BY name
4.
SELECT name FROM world
WHERE population > (SELECT population FROM world
WHERE name = 'Canada')
AND population < (SELECT population FROM world
WHERE name = 'Poland')
5.
SELECT name, CONCAT(ROUND(population / (SELECT population FROM world WHERE name = 'Germany') * 100),'%') AS "percentage" FROM world
WHERE continent = 'Europe'
6.
SELECT name FROM world
WHERE GDP > (SELECT MAX(GDP) FROM world WHERE continent LIKE 'Europe')
7.
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area > 0)
8.
SELECT continent, name FROM world x
WHERE name <= ALL
  (SELECT name FROM world y WHERE y.continent=x.continent)
9.
SELECT name, continent, population FROM world x
  WHERE 25000000 >= ALL (SELECT population FROM world y
                         WHERE x.continent=y.continent
                         AND population > 0)
10.
select name,continent from world x
where x.population >= ALL (select y.population * 3 from world y 
where y.continent=x.continent and population > 0 and x.name!=y.name )
