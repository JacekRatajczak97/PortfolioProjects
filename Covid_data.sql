select location,date_cov, total_cases, new_cases, total_deaths, population
from covid_data
order by 1,2;


--Total cases vs total deaths
select location,date_cov, total_cases, total_deaths, ROUND((total_deaths/total_cases)*100,2) AS DeathPercentage
from covid_data
where location LIKE '%Poland%'
order by 1,2;


--Looking at Total Cases vs Population
select location,date_cov, total_cases, population, ROUND((total_cases/population)*100,2) AS PercentPeopleInfected
from covid_data
order by 1,2;

--Countries with highest infection rate compered to population
select location, population, MAX(total_cases) AS HighestInfectionCoun, MAX((total_cases/population)*100) AS PercentPeopleInfected 
from covid_data
group by location, population
order by PercentPeopleInfected DESC NULLS LAST;


--Showing Countries with highest death count per population 
select location, MAX(total_deaths) as TotalDeathCount
from covid_data
where continent is null
group by location
order by TotalDeathCount DESC NULLS LAST;


-- Showing continents with highest death count
select continent, MAX(total_deaths) as TotalDeathCount
from covid_data
where continent is not null
group by continent
order by TotalDeathCount DESC NULLS LAST;


-- Global Numbers
Select to_char(date_cov, 'YYYY-MM-DD') as "data", SUM(new_cases)as TotalCases, SUM(new_deaths) as TotalDeaths, SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage
From covid_data
Where continent is not null
Group By date_cov
Order By 1,2 ;

--CTE
With global_numbs as (
Select to_char(date_cov, 'YYYY-MM-DD') as "data", SUM(new_cases)as TotalCases, SUM(new_deaths) as TotalDeaths, SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage
From covid_data
Where continent is not null
Group By date_cov
Order By 1,2
)
Select * FROM global_numbs

--TEMP TABLE
CREATE PRIVATE TEMPORARY TABLE ora$ptt_globalnumbers AS
Select to_char(date_cov, 'YYYY-MM-DD') as "data", SUM(new_cases)as TotalCases, SUM(new_deaths) as TotalDeaths, SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage
From covid_data
Where continent is not null
Group By date_cov
Order By 1,2



