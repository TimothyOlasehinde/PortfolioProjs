
/*
=============================================
Loading datasets into the tables 
  - portfolioproj.CovidDeaths
  - portfolioproj.CovidVaccinations

This script loads both tables with the contents of the csv files.
=============================================
*/

---------------------------------------------
-- Loading data into portfolioproj.CovidDeaths Table

TRUNCATE TABLE portfolioproj.CovidDeaths;
COPY portfolioproj.CovidDeaths
FROM '/Applications/DATE SCI PROJ/PortfolioProject_files/sql_python_proj/covid19_deaths_proj/CovidDeaths1.csv'
ENCODING 'UTF8'
DELIMITER ','
CSV HEADER;

---------------------------------------------
-- Loading data into portfolioproj.CovidVaccinations Table 

TRUNCATE TABLE portfolioproj.CovidVaccinations;
COPY portfolioproj.CovidVaccinations
FROM '/Applications/DATE SCI PROJ/PortfolioProject_files/sql_python_proj/covid19_deaths_proj/Covidvaccination1.csv'
ENCODING 'UTF8'
DELIMITER ','
CSV HEADER;
