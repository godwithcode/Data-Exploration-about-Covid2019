select * 
from PortfolioProject..CovidDeaths

select * 
from PortfolioProject..CovidVaccinations
where continent <> '' 

-- Select data that we are going to be using

select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
order by 1,2

-- looking at total cases and total deaths
-- Shows likelihood of dying if you contract covid in your country

Select location, date, total_cases,total_deaths, 
(CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0)) * 100 AS Deathpercentage
from PortfolioProject..covidDeaths
where location like '%states%'
and continent <> ''
order by 1,2
 
 -- looking at total cases and population
 -- shows what percentage of population got covid

Select location, convert(DATE,date,103) Date, total_cases,population, 
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

-- Let's break things down by contient
-- Showing contients with the highest death count per population

Select continent, max(CONVERT(float, total_deaths)) as TotalDeathCount
from PortfolioProject..covidDeaths
where continent <> '' 
group by continent
order by TotalDeathCount desc

-- Global numbers

Select convert(DATE,date,103) Date, sum(convert(float,new_cases)) as total_cases,sum(convert(float,new_deaths)) as total_deaths, 
(sum(CONVERT(float, new_deaths)) / sum(NULLIF(CONVERT(float, new_cases), 0))) * 100 AS Deathpercentage
from PortfolioProject..covidDeaths
where continent <> ''
group by date
order by 1,4

-- Percentage of global numbers

Select sum(convert(float,new_cases)) as total_cases,sum(convert(float,new_deaths)) as total_deaths, 
(sum(CONVERT(float, new_deaths)) / sum(NULLIF(CONVERT(float, new_cases), 0))) * 100 AS Deathpercentage
from PortfolioProject..covidDeaths
where continent <> ''
order by 1,2


--  Looking at Total Population vs Vaccinations
select dea.continent, dea.location, (convert(DATE,dea.date,103)) Date, dea.population, vac.new_vaccinations
, sum(convert(float,vac.new_vaccinations)) over (partition by dea.Location Order by dea.location, dea.Date)
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date	
where dea.continent <> ''
order by 2,3

