create database worldcupMatch;
use worldcupMatch;
select * from worldcupmatches_cleaned;

#1️. View all records
SELECT * FROM worldcupmatches_cleaned;

#2. Select specific columns
SELECT Year, `Home Team Name` , `Away Team Name` FROM worldcupmatches_cleaned;

#3. Matches played in 2014
SELECT * 
FROM worldcupmatches_cleaned
WHERE Year = 2014; 

#4. Matches where Home team scored more than 3 goals
SELECT * 
FROM worldcupmatches_cleaned
WHERE `Home Team Goals` > 3; 

#5. Matches played in London
SELECT * 
FROM worldcupmatches_cleaned
WHERE City = 'London';

#6. Sort matches by attendance (highest first)
SELECT * 
FROM worldcupmatches_cleaned
ORDER BY Attendance DESC;

#7. Get top 10 highest attended matches
SELECT * 
FROM worldcupmatches_cleaned
ORDER BY Attendance DESC
LIMIT 10;

#8. Count total matches
SELECT COUNT(*) AS Total_Matches 
FROM worldcupmatches_cleaned;

#9. Get distinct years
SELECT DISTINCT Year 
FROM worldcupmatches_cleaned
ORDER BY Year;

#10. Get distinct stages
SELECT DISTINCT Stage 
FROM worldcupmatches_cleaned;

#11. Total goals scored in all matches
SELECT SUM(`Home Team Goals` + `Away Team Goals`) AS Total_Goals
FROM worldcupmatches_cleaned;

#12. Average attendance
SELECT AVG(Attendance) AS Avg_Attendance
FROM worldcupmatches_cleaned;

#13. Maximum goals scored in a match
SELECT MAX(`Home Team Goals`+ `Away Team Goals`) AS Max_Goals
FROM worldcupmatches_cleaned;

#14. Matches count per year
SELECT Year, COUNT(*) AS Match_Count
FROM worldcupmatches_cleaned
GROUP BY Year
ORDER BY Year;

#15. Total goals per year
SELECT Year, SUM(`Home Team Goals` + `Away Team Goals`) AS Total_Goals
FROM worldcupmatches_cleaned
GROUP BY Year
ORDER BY Year;

#16. Average goals per match by year
SELECT Year, ROUND(AVG(`Home Team Goals` + `Away Team Goals`),2) AS Avg_Goals
FROM worldcupmatches_cleaned
GROUP BY Year;

#17. Matches per stage
SELECT Stage, COUNT(*) AS Matches
FROM worldcupmatches_cleaned
GROUP BY Stage;

#18. Highest attendance by year
SELECT Year, MAX(Attendance) AS Max_Attendance
FROM worldcupmatches_cleaned
GROUP BY Year;

#19. Years where total goals > 100
SELECT Year, SUM(`Home Team Goals` + `Away Team Goals`) AS Total_Goals
FROM worldcupmatches_cleaned
GROUP BY Year
HAVING Total_Goals > 100;

#20. Cities with more than 5 matches
SELECT City, COUNT(*) AS Match_Count
FROM worldcupmatches_cleaned
GROUP BY City
HAVING COUNT(*) > 5;

#21. Total matches played in each country
SELECT `Home Team Name`, COUNT(*) AS Matches
FROM worldcupmatches_cleaned
GROUP BY `Home Team Name`;

#22. Average attendance per stage
SELECT Stage, AVG(Attendance) AS Avg_Attendance
FROM worldcupmatches_cleaned
GROUP BY Stage;

#23. Home teams that scored more than 10 total goals in a year
SELECT Year, `Home Team Name`, SUM(`Home Team Goals`) AS Total_Home_Goals
FROM worldcupmatches_cleaned
GROUP BY Year, `Home Team Name`
HAVING SUM(`Home Team Goals`) > 10;

#24. Away teams with highest total goals
SELECT `Away Team Name`, SUM(`Away Team Goals`) AS Total_Away_Goals
FROM worldcupmatches_cleaned
GROUP BY `Away Team Name`
ORDER BY Total_Away_Goals DESC;

#25. Match with highest total goals
SELECT *
FROM worldcupmatches_cleaned
ORDER BY (`Home Team Goals` + `Away Team Goals`) DESC
LIMIT 1;

#26. Final matches only
SELECT *
FROM worldcupmatches_cleaned
WHERE Stage = 'Final';

#27. Matches ending in a draw
SELECT *
FROM worldcupmatches_cleaned
WHERE `Home Team Goals` = `Away Team Goals`;


#28. Total wins by home team (approx)
SELECT COUNT(*) AS Home_Wins
FROM worldcupmatches_cleaned
WHERE `Home Team Goals` > `Away Team Goals`;

#29. Year with highest total attendance
SELECT Year, SUM(Attendance) AS Total_Attendance
FROM worldcupmatches_cleaned
GROUP BY Year
ORDER BY Total_Attendance DESC
LIMIT 1;

#30. Top 5 stadiums by number of matches
SELECT Stadium, COUNT(*) AS Matches
FROM worldcupmatches_cleaned
GROUP BY Stadium
ORDER BY Matches DESC
LIMIT 5;

#31. Team with most total goals (home + away)
SELECT Team, SUM(Goals) AS Total_Goals
FROM (
    SELECT `Home Team Name` AS Team, `Home Team Goals` AS Goals FROM worldcupmatches_cleaned
    UNION ALL
    SELECT `Away Team Name`, `Away Team Goals` FROM worldcupmatches_cleaned
) t
GROUP BY Team
ORDER BY Total_Goals DESC
LIMIT 1;


#32. Team with most wins
SELECT Team, COUNT(*) AS Wins
FROM (
    SELECT `Home Team Name` AS Team
    FROM worldcupmatches_cleaned
    WHERE `Home Team Goals` > `Away Team Goals`
    UNION ALL
    SELECT `Away Team Name`
    FROM worldcupmatches_cleaned
    WHERE `Away Team Goals` >  `Home Team Goals`
) t
GROUP BY Team
ORDER BY Wins DESC;

#33. Year with highest average goals per match
SELECT Year,
       AVG(`Home Team Goals` + `Away Team Goals`) AS Avg_Goals
FROM worldcupmatches_cleaned
GROUP BY Year
ORDER BY Avg_Goals DESC
LIMIT 1;

#34. Teams that never lost
SELECT Team
FROM (
    SELECT `Home Team Name` AS Team,
           CASE WHEN `Home Team Goals` < `Away Team Goals` THEN 1 ELSE 0 END AS Lost
    FROM worldcupmatches_cleaned
    UNION ALL
    SELECT `Away Team Name`,
           CASE WHEN `Away Team Goals` < `Home Team Goals` THEN 1 ELSE 0 END
    FROM worldcupmatches_cleaned
) t
GROUP BY Team
HAVING SUM(Lost) = 0;

#35. Highest scoring draw
SELECT *
FROM worldcupmatches_cleaned
WHERE `Home Team Goals` = `Away Team Goals`
ORDER BY `Home Team Goals` DESC
LIMIT 1;

#36. Team with highest goal difference
SELECT Team, SUM(GoalDiff) AS Total_Diff
FROM (
    SELECT `Home Team Name` AS Team, (`Home Team Goals` - `Away Team Goals`) AS GoalDiff
    FROM worldcupmatches_cleaned
    UNION ALL
    SELECT `Away Team Name`, ( `Away Team Goals` - `Home Team Goals`)
    FROM worldcupmatches_cleaned
) t
GROUP BY Team
ORDER BY Total_Diff DESC;

#37. Rank teams by total goals
SELECT Team,
       SUM(Goals) AS Total_Goals,
       RANK() OVER (ORDER BY SUM(Goals) DESC) AS Goal_Rank
FROM (
    SELECT `Home Team Name` AS Team, `Home Team Goals` AS Goals FROM worldcupmatches_cleaned
    UNION ALL
    SELECT `Away Team Name`,`Away Team Goals` FROM worldcupmatches_cleaned
) t
GROUP BY Team;

#38. Dense rank highest scoring matches per year
SELECT *,
       DENSE_RANK() OVER (PARTITION BY Year ORDER BY (`Home Team Goals` + `Away Team Goals`) DESC) AS Rank_Goals
FROM worldcupmatches_cleaned;

#39. Cities hosting most goals
SELECT City,
       SUM(`Home Team Goals` + `Away Team Goals`) AS Goals
FROM worldcupmatches_cleaned
GROUP BY City
ORDER BY Goals DESC;

#40. Team that conceded most goals
SELECT Team, SUM(Goals_Conceded) AS Conceded
FROM (
    SELECT `Home Team Name` AS Team, `Away Team Goals` AS Goals_Conceded FROM worldcupmatches_cleaned
    UNION ALL
    SELECT `Away Team Name`,`Home Team Goals` FROM worldcupmatches_cleaned
) t
GROUP BY Team
ORDER BY Conceded DESC;