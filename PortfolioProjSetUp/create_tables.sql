
/*
====================================================
Creating The Tables for the Project
  - portfolioproj.CovidDeaths
  - portfolioproj.CovidVaccinations
=====================================================
This query creates the tables and their structures. 
*/

-- ---------------------------------------------------
-- Dropping & Creating portfolioproj.CovidDeaths Table 

DROP TABLE IF EXISTS portfolioproj.CovidDeaths;
CREATE TABLE portfolioproj.CovidDeaths( 
	iso_code VARCHAR(50),
	continent VARCHAR(50),
	location VARCHAR(50),
	date DATE,
	population BIGINT,
	total_cases INT,
	new_cases INT,
	new_cases_smoothed DECIMAL,
	total_deaths INT,
	new_deaths INT, 
	new_deaths_smoothed DECIMAL, 
	total_cases_per_million DECIMAL,
	new_cases_per_million DECIMAL,
	new_cases_smoothed_per_million DECIMAL,
	total_deaths_per_million DECIMAL,
	new_deaths_per_million DECIMAL,
	new_deaths_smoothed_per_million DECIMAL,
	reproduction_rate DECIMAL,
	icu_patients INT, 
	icu_patients_per_million DECIMAL,
	hosp_patients INT, 
	hosp_patients_per_million DECIMAL,
	weekly_icu_admissions DECIMAL,
	weekly_icu_admissions_per_million DECIMAL,
	weekly_hosp_admissions DECIMAL,
	weekly_hosp_admissions_per_million DECIMAL
);


-- -----------------------------------------------------
-- Dropping & Creating portfolioproj.CovidVaccinations Table 

DROP TABLE IF EXISTS portfolioproj.CovidVaccinations;
CREATE TABLE portfolioproj.CovidVaccinations(
	iso_code VARCHAR(50),
	continent VARCHAR(50),
	location VARCHAR(50),
	date DATE,
	new_tests INT,
	total_tests INT,
	total_tests_per_thousand DECIMAL, 
	new_tests_per_thousand DECIMAL,
	new_tests_smoothed DECIMAL,
	new_tests_smoothed_per_thousand DECIMAL,
	positive_rate DECIMAL,
	tests_per_case DECIMAL,
	tests_units VARCHAR(50),
	total_vaccinations INT,
	people_vaccinated INT,
	people_fully_vaccinated INT,
	new_vaccinations INT,
	new_vaccinations_smoothed DECIMAL,
	total_vaccinations_per_hundred DECIMAL,
	people_vaccinated_per_hundred DECIMAL,
	people_fully_vaccinated_per_hundred DECIMAL, 
	new_vaccinations_smoothed_per_million DECIMAL, 
	stringency_index DECIMAL,
	population_density DECIMAL,
	median_age DECIMAL,
	aged_65_older DECIMAL,
	aged_70_older DECIMAL,
	gdp_per_capital DECIMAL,
	extreme_poverty DECIMAL,
	cardiovasc_death_rate DECIMAL,
	diabetes_prevalence DECIMAL,
	female_smokers DECIMAL,
	male_smokers DECIMAL, 
	handwashing_facilities DECIMAL, 
	hospital_beds_per_thousand DECIMAL, 
	life_expectancy DECIMAL,
	human_development_index DECIMAL
);


