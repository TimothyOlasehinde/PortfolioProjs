-- FROM portfolioproj.CovidDeaths
-- FROM portfolioproj.CovidVaccinations

SELECT *
FROM portfolioproj.coviddeaths
WHERE continent IS NOT NULL

-- Looking at Total Cases vs Total Deaths 
-- Shows likelyhood of dying from Covid from my country (Nigeria)
SELECT l
	ocation, 
	date, 
	total_cases, 
	total_deaths, 
	((total_deaths)::FLOAT /(total_cases)::FLOAT)*100 DeathPercentage
FROM portfolioproj.CovidDeaths
WHERE LOCATION = 'Nigeria'
ORDER BY 1, 2

-- Looking at Total Cases vs Population
-- Shows what percentage of population got Covid 
SELECT 
	location, 
	date, 
	total_cases, 
	population, 
	((total_cases)::FLOAT /(population)::FLOAT)*100 PercentOFPopulationInfected
FROM portfolioproj.CovidDeaths
-- WHERE LOCATION = 'Nigeria'
ORDER BY 1, 2

-- Looking at Countries with Highest Infection Rate compared to Population
SELECT 
	location, 
	population, 
	MAX(total_cases) HighestInfection, 
	MAX((total_cases)::FLOAT /(population)::FLOAT)*100 PercentagePopulationInfected
FROM portfolioproj.CovidDeaths
-- WHERE LOCATION = 'Nigeria'
GROUP BY 
	location, 
	population
ORDER BY PercentagePopulationInfected DESC

--Showing the Countries with the Highest Death Count Per Population 
SELECT 
	location, 
	MAX(total_deaths)::INT TotalDeathCount
FROM portfolioproj.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC

-- LETS BREAK THINGS DOWN BY CONTINENT

-- Showing the Total Deaths by Continents 
SELECT 
	location, 
	MAX(total_deaths)::INT TotalDeathCount
FROM portfolioproj.CovidDeaths
WHERE continent IS NULL
GROUP BY location
ORDER BY TotalDeathCount DESC

-- GLOBAL NUMBERS 

-- Total Cases, Deaths and percentage per day
SELECT  
	date,
	SUM(new_cases) total_cases, 
	SUM(new_deaths::INT) total_deaths, 
	SUM((new_deaths)::FLOAT) / SUM(NULLIF(new_cases, 0)::FLOAT) * 100 
FROM portfolioproj.CovidDeaths
WHERE continent IS NULL
GROUP BY date
ORDER BY 1,2

-- Total Cases and Deaths as well as the Percentage of deaths to cases  
SELECT  
	SUM(new_cases) total_cases, 
	SUM(new_deaths::INT) total_deaths, 
	SUM((new_deaths)::FLOAT) / SUM(NULLIF(new_cases, 0)::FLOAT) * 100 
FROM portfolioproj.CovidDeaths
WHERE continent IS NULL
ORDER BY 1,2

--Joining all the cointent from both Tables (portfolioproj.CovidDeaths & portfolioproj.CovidVaccinations)
SELECT 
	*
FROM portfolioproj.CovidDeaths dea
JOIN portfolioproj.CovidVaccinations vac
	ON dea.location = vac.location 
	AND dea.date = vac.date

-- Looking at Total Population vs Vaccinations

SELECT 
	dea.continent,
	dea.location, 
	dea.date,
	dea.population,
	vac.new_vaccinations,
	SUM(new_vaccinations) OVER(PARTITION BY dea.location ORDER BY dea.location, dea.date) AggregateTotal
FROM portfolioproj.CovidDeaths dea
JOIN portfolioproj.CovidVaccinations vac
	ON dea.location = vac.location 
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2, 3

-- Using CTE to find the percentage of the Vaccinated Population vs the Total Population

WITH PopovsVac AS (
	SELECT 
	dea.continent,
	dea.location, 
	dea.date,
	dea.population,
	vac.new_vaccinations,
	SUM(new_vaccinations) OVER(PARTITION BY dea.location ORDER BY dea.location, dea.date) AggregateTotal
FROM portfolioproj.CovidDeaths dea
JOIN portfolioproj.CovidVaccinations vac
	ON dea.location = vac.location 
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
) 
SELECT 
	continent,
	location, 
	date,
	population,
	new_vaccinations,
	(AggregateTotal/population)*100 AggregatePercentageVaccinated
FROM PopovsVac
ORDER BY 2, 3

-- Using Temporary Table to find the percentage of the Vaccinated Population vs the Total Population
DROP TABLE IF EXISTS PercentagePopulationVaccinated;
CREATE TEMP TABLE PercentagePopulationVaccinated(
continent VARCHAR(255),
location VARCHAR (255),
date DATE, 
populaton BIGINT,
new_vaccinations INT,
AggregateTotal DECIMAL
);
INSERT INTO PercentagePopulationVaccinated(
	SELECT 
	dea.continent,
	dea.location, 
	dea.date,
	dea.population,
	vac.new_vaccinations,
	SUM(new_vaccinations) OVER(PARTITION BY dea.location ORDER BY dea.location, dea.date) AggregateTotal
FROM portfolioproj.CovidDeaths dea
JOIN portfolioproj.CovidVaccinations vac
	ON dea.location = vac.location 
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL);

SELECT 
	* 
FROM PercentagePopulationVaccinated

-- Creating Views to store data for later visualization 
CREATE VIEW ViewPercentagePopulationVaccinated AS
	SELECT 
	dea.continent,
	dea.location, 
	dea.date,
	dea.population,
	vac.new_vaccinations,
	SUM(new_vaccinations) OVER(PARTITION BY dea.location ORDER BY dea.location, dea.date) AggregateTotal
FROM portfolioproj.CovidDeaths dea
JOIN portfolioproj.CovidVaccinations vac
	ON dea.location = vac.location 
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;

SELECT 
	* 
FROM ViewPercentagePopulationVaccinated

