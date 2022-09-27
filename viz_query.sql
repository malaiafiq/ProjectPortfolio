-- for total death

SELECT location, MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM   dbo.covidDeath$
WHERE (continent IS NULL) 
AND (location NOT IN ('World', 'European Union', 'International'))
GROUP BY location

-- Global numbers

SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS INT)) AS total_death, SUM(CAST(new_deaths AS INT)) / SUM(new_cases) * 100 AS DeathPercentage
FROM   dbo.covidDeath$
WHERE (continent IS NOT NULL)

-- Highest infection

SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX(total_cases / population) * 100 AS PercentPouplationInfected, date
FROM   dbo.covidDeath$
GROUP BY location, population, date

-- Highest Infection VS population

SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX(total_cases / population * 100) AS PercentPouplationInfected
FROM   dbo.covidDeath$
GROUP BY location, population
