--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-05-30 07:54:38

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 24844)
-- Name: CovidDeaths; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CovidDeaths" (
    iso_code character varying NOT NULL,
    continent character varying,
    date date NOT NULL,
    location character varying NOT NULL,
    population numeric NOT NULL,
    total_cases numeric,
    new_cases numeric,
    new_cases_smoothed numeric,
    total_deaths numeric,
    new_deaths numeric,
    new_deaths_smoothed numeric,
    total_cases_per_million numeric,
    new_cases_per_million numeric,
    new_cases_smoothed_per_million numeric,
    total_deaths_per_million numeric,
    new_deaths_per_million numeric,
    new_deaths_smoothed_per_million numeric,
    reproduction_rate numeric,
    icu_patients numeric,
    icu_patients_per_million numeric,
    hosp_patients numeric,
    hosp_patients_per_million numeric,
    weekly_icu_admissions numeric,
    weekly_icu_admissions_per_million numeric,
    weekly_hosp_admissions numeric,
    weekly_hosp_admissions_per_million numeric
);


ALTER TABLE public."CovidDeaths" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 24849)
-- Name: CovidVacinations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CovidVacinations" (
    iso_code character varying NOT NULL,
    continent character varying,
    date date NOT NULL,
    location character varying NOT NULL,
    total_tests numeric,
    new_tests numeric,
    total_tests_per_thousand numeric,
    new_tests_per_thousand numeric,
    new_tests_smoothed numeric,
    new_tests_smoothed_per_thousand numeric,
    positive_rate numeric,
    tests_per_case numeric,
    tests_units character varying,
    total_vaccinations numeric,
    people_vaccinated numeric,
    people_fully_vaccinated numeric,
    total_boosters numeric,
    new_vaccinations numeric,
    new_vaccinations_smoothed numeric,
    total_vaccinations_per_hundred numeric,
    people_vaccinated_per_hundred numeric,
    people_fully_vaccinated_per_hundred numeric,
    total_boosters_per_hundred numeric,
    new_vaccinations_smoothed_per_million numeric,
    new_people_vaccinated_smoothed numeric,
    new_people_vaccinated_smoothed_per_hundred numeric,
    stringency_index numeric,
    population_density numeric,
    median_age numeric,
    aged_65_older numeric,
    aged_70_older numeric,
    gdp_per_capita numeric,
    extreme_poverty numeric,
    cardiovasc_death_rate numeric,
    diabetes_prevalence numeric,
    female_smokers numeric,
    male_smokers numeric,
    handwashing_facilities numeric,
    hospital_beds_per_thousand numeric,
    life_expectancy numeric,
    human_development_index numeric,
    excess_mortality_cumulative_absolute numeric,
    excess_mortality_cumulative numeric,
    excess_mortality numeric,
    excess_mortality_cumulative_per_million numeric
);


ALTER TABLE public."CovidVacinations" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24869)
-- Name: percentpopulationvaccinated; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.percentpopulationvaccinated AS
 SELECT cd.continent,
    cd.location,
    cd.date,
    cd.population,
    cv.new_vaccinations,
    sum(cv.new_vaccinations) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) AS rollingpeoplevaccinated
   FROM (public."CovidDeaths" cd
     JOIN public."CovidVacinations" cv ON ((((cd.location)::text = (cv.location)::text) AND (cd.date = cv.date))))
  WHERE (cd.continent IS NOT NULL);


ALTER VIEW public.percentpopulationvaccinated OWNER TO postgres;

-- Completed on 2024-05-30 07:54:38

--
-- PostgreSQL database dump complete
--

