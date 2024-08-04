CREATE OR REPLACE VIEW ath_CurrentOlympicGames AS
SELECT athlete_id, event, org_name
FROM award WHERE org_name='2024 Summer';

CREATE OR REPLACE VIEW ath_AwardPreviousOG AS
SELECT DISTINCT a1.athlete_id, a1.event
FROM ath_CurrentOlympicGames a1 JOIN award a2 
ON a1.athlete_id=a2.athlete_id AND a1.event=a2.event
WHERE a1.org_name!=a2.org_name AND a2.metal IN ('Gold','Silver','Bronze');

SELECT athlete_id ID, athlete_name||' '||athlete_surname fullname,
       bdate birthDate, sex, event
FROM athlete NATURAL JOIN ath_AwardPreviousOG 
ORDER BY ID;

CREATE OR REPLACE VIEW ath_team_CurrentOG AS
SELECT athlete_id, country
FROM participation NATURAL JOIN team
WHERE org_name='2024 Summer';

SELECT country, event, COUNT(*) athletes
FROM ath_team_CurrentOG a1 JOIN ath_CurrentOlympicGames a2
ON a1.athlete_id=a2.athlete_id
GROUP BY country, event
ORDER BY country, athletes desc;

CREATE OR REPLACE VIEW events_AppearancesOG AS
SELECT event, COUNT(*) appearances
FROM (SELECT event, org_name FROM award GROUP BY event, org_name)
GROUP BY event
HAVING COUNT(*) <= 2;

SELECT * FROM competition NATURAL JOIN events_AppearancesOG
ORDER BY sport;

CREATE OR REPLACE VIEW GoldMedalsPerCountry AS
SELECT t.country, COUNT(*) AS GoldMedals
FROM award a JOIN participation p 
ON a.athlete_id=p.athlete_id AND a.org_name=p.org_name
JOIN team t ON p.noc=t.noc
WHERE a.metal='Gold'
GROUP BY t.country;

SELECT *
FROM GoldMedalsPerCountry
WHERE GoldMedals =
  (SELECT MAX(GoldMedals)FROM GoldMedalsPerCountry);

CREATE OR REPLACE VIEW ath_participations AS
SELECT ath.athlete_id, org_name
FROM athlete ath JOIN participation p
ON ath.athlete_id=p.athlete_id
WHERE athlete_name='Miltiadis' AND athlete_surname='Tentoglou';

SELECT athlete_id ID, athlete_name||' '||athlete_surname fullname,
       bdate birthDate, sex, participations  
FROM athlete NATURAL JOIN
    (SELECT athlete_id, COUNT(*) participations
     FROM ath_participations
     GROUP BY athlete_id);
