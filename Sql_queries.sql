--SQL Query Charts
--crime over year

SELECT TO_CHAR(crimedate, 'YYYY') AS year,
       COUNT(*) AS total_crimes
FROM   crime
GROUP BY TO_CHAR(crimedate, 'YYYY')
ORDER BY year;

-- Crime solved

SELECT TO_CHAR(c.CrimeDate, 'YYYY') AS Year,
       COUNT(c.Crime_id) AS Crimes_Reported,
       COUNT(e.Evidence_id) AS Evidence_Collected
FROM Crime c
LEFT JOIN Evidence e ON c.Crime_id = e.Crime_id
GROUP BY TO_CHAR(c.CrimeDate, 'YYYY')
ORDER BY Year;

--Crime Types
SELECT Type AS Crime_Type,
       COUNT(*) AS Crime_Count
FROM Crime
GROUP BY Type
ORDER BY Crime_Count DESC;

--Volunteer Hours By project
SELECT 
  Project_id,
  SUM(Hours) AS Total_Volunteer_Hours
FROM VolunteerHour
GROUP BY Project_id
ORDER BY Total_Volunteer_Hours DESC;

-- Crimes by location with officer Rank

SELECT TO_CHAR(c.CrimeDate, 'YYYY') AS Year,c.Location, 
 SUM(CASE WHEN o.Rank = 'Inspector' THEN 1 ELSE 0 END) AS Inspector_Involvement, 
 SUM(CASE WHEN o.Rank = 'Detective' THEN 1 ELSE 0 END) AS Detective_Involvement 
 FROM Crime c 
 JOIN CrimeOfficer co 
 ON c.Crime_id = co.Crime_id 
 JOIN Officer o 
 ON co.Officer_id = o.Officer_id 
 GROUP BY TO_CHAR(c.CrimeDate, 'YYYY'), c.Location ORDER BY Year

--Evidence Types
SELECT Type,
       COUNT(*) AS Evidence_Count
FROM Evidence
GROUP BY Type
ORDER BY Evidence_Count DESC;