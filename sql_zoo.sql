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
/*Tutorial 4 */
1.
SELECT SUM(population)
FROM world
2.
SELECT DISTINCT continent FROM world
3.
SELECT SUM(GDP) FROM world
WHERE continent LIKE 'Africa'
4.
SELECT COUNT(name) FROM world
WHERE area >= 1000000
5.
SELECT SUM(population) FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania')
6.
SELECT DISTINCT continent, COUNT(name) FROM world
GROUP BY continent
7.
SELECT continent, COUNT(name) FROM world
 WHERE population >= 10000000
 GROUP BY continent
8.
SELECT continent
  FROM world
 GROUP BY continent
HAVING SUM(population) > 100000000
/*Tutorial 5 */
1.
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'
2.
SELECT id,stadium,team1,team2
  FROM game
WHERE id = 1012
3.
SELECT player,teamid, stadium, mdate
  FROM game JOIN goal ON (game.id=goal.matchid)
WHERE teamid = 'GER'
4.
SELECT team1, team2, player 
FROM game JOIN goal ON (game.id=goal.matchid)
WHERE player LIKE 'Mario%'
5.
SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam ON (eteam.id=goal.teamid)
 WHERE gtime<=10
6.
SELECT mdate, teamname 
FROM game JOIN eteam ON (game.team1=eteam.id)
WHERE coach = 'Fernando Santos'
7.
SELECT player 
FROM goal JOIN game ON (goal.matchid=game.id)
WHERE stadium = 'National Stadium, Warsaw'
8.
SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id 
    WHERE teamid != 'GER'
AND (team1 = 'GER' OR team2 = 'GER')
9.
SELECT teamname,count(teamname) AS 'Goals'
FROM eteam JOIN goal
ON eteam.id=goal.teamid
group by teamname
10.
SELECT stadium,COUNT(*) AS 'Goals'
FROM game JOIN goal
WHERE game.id=goal.matchid
GROUP BY stadium
11.
SELECT matchid,mdate,COUNT(gtime) AS 'Goals'
FROM game JOIN goal
ON goal.matchid = game.id
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid,mdate
12.
SELECT matchid,mdate,COUNT(gtime) AS 'Goals'
FROM game JOIN goal
ON goal.matchid = game.id
WHERE goal.teamid = 'GER'
GROUP BY matchid,mdate
13.
SELECT game.mdate, game.team1, 
SUM(CASE WHEN goal.teamid = game.team1 THEN 1 ELSE 0 END) AS 'score1',
game.team2,
SUM(CASE WHEN goal.teamid = game.team2 THEN 1 ELSE 0 END) AS 'score2'
FROM game LEFT JOIN goal ON matchid = id
GROUP BY game.id,game.mdate, game.team1, game.team2 
ORDER BY mdate,matchid,team1,team2
/*Tutorial 6 */
1.
SELECT name FROM teacher
WHERE dept IS NULL
2.
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)
3.
SELECT teacher.name, dept.name
 FROM teacher LEFT JOIN dept
           ON (teacher.dept=dept.id)
4.
SELECT teacher.name, dept.name
 FROM teacher RIGHT JOIN dept
           ON (teacher.dept=dept.id)
5.
SELECT name, COALESCE(mobile,'07986 444 2266') AS 'mobile'
  FROM teacher
6.
SELECT teacher.name, COALESCE(dept.name,'None')
FROM teacher LEFT JOIN dept
ON teacher.dept=dept.id
7.
SELECT COUNT(name), COUNT(mobile)
FROM teacher
8.
SELECT DISTINCT dept.name, COUNT(teacher.name)
FROM teacher RIGHT JOIN dept ON teacher.dept = dept.id
GROUP BY dept.name
9.
SELECT teacher.name
       ,CASE WHEN (teacher.dept = 1 OR teacher.dept = 2)
             THEN 'Sci'
             ELSE 'Art'
end
FROM teacher
10.
SELECT teacher.name
       ,CASE WHEN (teacher.dept = 1 OR teacher.dept = 2)
             THEN 'Sci'
             WHEN (teacher.dept = 3)
             THEN 'Art'
             ELSE 'None'
end
FROM teacher
/*Tutorial 7 */
1.
SELECT count(id) FROM stops
2.
SELECT id FROM stops
where name = 'Craiglockhart'
3.
SELECT id, name FROM stops, route
WHERE id=stop
AND company='LRT'
AND num='4'
4.
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) = 2
5.
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
(a.company=b.company AND a.num=b.num)
WHERE a.stop = 53 AND b.stop=149
6.
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
(a.company=b.company AND a.num=b.num)
JOIN stops stopa ON (a.stop=stopa.id)
JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'
AND stopb.name='London Road'
7.
SELECT DISTINCT R1.company, R1.num
FROM route R1, route R2
WHERE R1.num=R2.num AND R1.company=R2.company
AND R1.stop=115 AND R2.stop=137
8.
SELECT R1.company, R1.num
FROM route R1, route R2, stops S1, stops S2
WHERE R1.num=R2.num AND R1.company=R2.company
AND R1.stop=S1.id AND R2.stop=S2.id
AND S1.name='Craiglockhart'
AND S2.name='Tollcross'
9.
SELECT DISTINCT S2.name, R2.company, R2.num
FROM stops S1, stops S2, route R1, route R2
WHERE S1.name='Craiglockhart'
AND S1.id=R1.stop
AND R1.company=R2.company AND R1.num=R2.num
AND R2.stop=S2.id

