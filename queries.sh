#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "select sum(winner_goals+opponent_goals) from games")"


echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "select avg(winner_goals) from games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "select ROUND(avg(winner_goals),2) from games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "select AVG(winner_goals+opponent_goals) from games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "select max(greatest(winner_goals, opponent_goals)) from games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL " select count(game_id) from games where winner_goals>2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT ww.name FROM games AS gg LEFT JOIN teams AS ww ON gg.winner_id = ww.team_id WHERE gg.round LIKE 'Final' AND year = 2018")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT t.team FROM ((SELECT w.name AS team, g.round AS round, g.year AS year FROM games AS g LEFT JOIN teams AS w ON g.winner_id = w.team_id) 
UNION (SELECT l.name AS team, g.round AS round, g.year AS year FROM games AS g LEFT JOIN teams AS l ON g.opponent_id = l.team_id)) AS t 
WHERE t.round LIKE 'Eighth-Final' AND t.year = 2014 ORDER BY t.team")"



echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT DISTINCT(ww.name) FROM games as gg LEFT JOIN teams as ww ON gg.winner_id = ww.team_id ORDER BY ww.name")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT g.year, t.name FROM games AS g LEFT JOIN teams AS t ON g.winner_id = t.team_id WHERE g.round LIKE 'Final' ORDER BY g.year")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT t.name FROM games AS g LEFT JOIN teams AS t ON g.winner_id = t.team_id WHERE t.name LIKE 'Co%'")"
