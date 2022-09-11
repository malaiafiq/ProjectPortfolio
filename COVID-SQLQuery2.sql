
SELECT *
FROM ProjectPortfolio..covidDeath$
ORDER BY 3,4

--SELECT *
--FROM ProjectPortfolio..covidVaccination$
--ORDER BY 3,4

-- Looking at total cases vs total deaths
SELECT location,
	date,
	total_cases,
	total_deaths,
	(total_deaths/total_cases)*100 as DeathPercentage
FROM ProjectPortfolio..covidDeath$
WHERE location like '%kingdom%'
order by 1,2

--looking at total cases vs population
--shows what % of population got covid
SELECT location,
	date,
	population,
	total_cases,
	(total_cases/population)*100 as PercentPouplationInfected
FROM ProjectPortfolio..covidDeath$
WHERE location like '%kingdom%'
order by 1,2

--Looking at countries with highest infection rate compared to population
SELECT location,
	population,
	MAX(total_cases) as HighestInfectionCount,
	MAX((total_cases/population)*100) as PercentPouplationInfected
FROM ProjectPortfolio..covidDeath$
--WHERE location like '%kingdom%'
GROUP BY location,population
order by PercentPouplationInfected DESC

--showing countries with highest death count per population
SELECT location,
	MAX(cast(total_deaths as int)) AS  TotalDeathCount
FROM ProjectPortfolio..covidDeath$
--WHERE location like '%kingdom%'
WHERE continent IS NOT NULL
GROUP BY location
order by TotalDeathCount DESC


-- BREAK DOWN BY CONTINENT
SELECT continent,
	MAX(cast(total_deaths as int)) AS  TotalDeathCount
FROM ProjectPortfolio..covidDeath$
--WHERE location like '%kingdom%'
WHERE continent IS NOT NULL
GROUP BY continent
order by TotalDeathCount DESC

-- GLOBAL NUMBERS
SELECT SUM(new_cases) as total_cases,
	SUM(CAST(new_deaths AS INT)) as total_death,
	SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 AS DeathPercentage
FROM ProjectPortfolio..covidDeath$
--WHERE location like '%kingdom%'
WHERE CONTINENT IS NOT NULL
--GROUP BY DATE
order by 1,2

-- LOOKING AT TOTAL POPULATION VS VACCINATIONS
SELECT DEA.continent, 
		DEA.location, 
		DEA.date, 
		DEA.population, 
		VAC.new_vaccinations,
		SUM(cast(VAC.new_vaccinations as bigint)) OVER (PARTITION BY DEA.location ORDER BY DEA.LOCATION,
		DEA.date) as RollingPeopleVaccinated
		--(RollingPeopleVaccinated/population)*100
FROM ProjectPortfolio..covidDeath$ DEA
JOIN ProjectPortfolio..covidVaccination$ VAC
	ON DEA.location = VAC.location
	AND DEA.date = VAC.date
WHERE DEA.continent IS NOT NULL
--ORDER BY 2,3


-- USE CTE
WITH PopvsVac (Continent, location, date, Population, new_vaccinations,RollingPeopleVaccinated)
AS
(
SELECT DEA.continent, 
		DEA.location, 
		DEA.date, 
		DEA.population, 
		VAC.new_vaccinations,
		SUM(CONVERT(BIGINT,VAC.new_vaccinations)) OVER (PARTITION BY DEA.location ORDER BY DEA.LOCATION, DEA.date) as RollingPeopleVaccinated
FROM ProjectPortfolio..covidDeath$ DEA
JOIN ProjectPortfolio..covidVaccination$ VAC
	ON DEA.location = VAC.location
	AND DEA.date = VAC.date
WHERE DEA.continent IS NOT NULL
--ORDER BY 2,3
)
SELECT *, (RollingPeopleVaccinated/Population)*100
FROM PopvsVac

-- TEMP TABLE
DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255),
location nvarchar(255),
Date datetime,
Population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT DEA.continent, 
		DEA.location, 
		DEA.date, 
		DEA.population, 
		VAC.new_vaccinations,
		SUM(CONVERT(BIGINT,VAC.new_vaccinations)) OVER (PARTITION BY DEA.location ORDER BY DEA.LOCATION, DEA.date) as RollingPeopleVaccinated
FROM ProjectPortfolio..covidDeath$ DEA
JOIN ProjectPortfolio..covidVaccination$ VAC
	ON DEA.location = VAC.location
	AND DEA.date = VAC.date
WHERE DEA.continent IS NOT NULL
--ORDER BY 2,3

SELECT *, (RollingPeopleVaccinated/Population)*100
FROM #PercentPopulationVaccinated

-- CREATING VIEW TO STORE DATA FOR LATER VISUALIZATION
CREATE VIEW PercentPopulationVaccinated AS
SELECT DEA.continent, 
		DEA.location, 
		DEA.date, 
		DEA.population, 
		VAC.new_vaccinations,
		SUM(CONVERT(BIGINT,VAC.new_vaccinations)) OVER (PARTITION BY DEA.location ORDER BY DEA.LOCATION, DEA.date) as RollingPeopleVaccinated
FROM ProjectPortfolio..covidDeath$ DEA
JOIN ProjectPortfolio..covidVaccination$ VAC
	ON DEA.location = VAC.location
	AND DEA.date = VAC.date
WHERE DEA.continent IS NOT NULL
--ORDER BY 2,3

SELECT *
FROM PercentPopulationVaccinated
