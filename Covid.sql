select * 
from PortfolioProject..CovidDeaths
where continent <> '' 

select * 
from PortfolioProject..CovidVaccinations
where continent <> '' 

-- Select data that we are going to be using

select location, date, total_cases, new_cases, total_deaths, population
from CovidDeaths
order by 1,2

-- looking at total cases and total deaths
-- Shows likelihood of dying if you contract covid in your country

Select location, date, total_cases,total_deaths, 
(CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0)) * 100 AS Deathpercentage
from PortfolioProject..covidDeaths
where location like '%states%'
and continent is not NULL
order by 1,2
 
 -- looking at total cases and population
 -- shows what percentage of population got covid

Select location, date, total_cases,population, 
(CONVERT(float, total_cases) / NULLIF(CONVERT(float, population), 0)) * 100 AS PercentagePopulationInfected
from PortfolioProject..covidDeaths
--where location like '%states%'
where continent <> '' 
order by 1,4

-- looking at countries with Highest Infection Rate compared to Population


Select location, population, max(CONVERT(float, total_cases)) as HighestInfectionCount,  
max((CONVERT(float, total_cases) / NULLIF(CONVERT(float, population), 0))) * 100 AS PercentagePopulationInfected
from PortfolioProject..covidDeaths
where continent <> '' 
group by location,population
order by PercentagePopulationInfected desc

-- Showing Countries with Highest Death Count per Population

Select location, max(CONVERT(float, total_deaths)) as TotalDeathCount
from PortfolioProject..covidDeaths
where continent <> '' 
group by location,population
order by TotalDeathCount desc