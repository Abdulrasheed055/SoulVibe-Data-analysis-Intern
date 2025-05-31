create DATABASE soulvibe_internship;


CREATE TABLE demographics_data (
    Age INT,
    Education_Level VARCHAR,
    Occupation VARCHAR,
    Number_of_Dependents INT,
    Location VARCHAR,
    Work_Experience INT,
    Marital_Status VARCHAR,
    Employment_Status VARCHAR,
    Household_Size INT,
    Homeownership_Status VARCHAR,
    Type_of_Housing VARCHAR,
    Gender VARCHAR,
    Primary_Mode_of_Transportation VARCHAR,
    Income NUMERIC
);

select * from demographics_data limit 5


-- 1. Average Income by Education Level (Full-time)
select education_level, 
round(avg(income),1) as average_income
from demographics_data
where employment_status='Full-time'
group by education_level;


-- 2. Top 5 Highest Earning Individuals
-- Retrieve details of top 5 individuals with highest income

select * from
demographics_data
order by income desc
limit 5;


---3. Count People by Occupation with >2 Dependents & Own House
-- Count number of people per occupation who have >2 dependents and own their house

select occupation,count(*) As total_people
from demographics_data
where number_of_dependents >2 AND homeownership_status='Own'
group by occupation;

--4. Urban Residents Earning Above Average
---- List people in Urban locations earning above overall average income

select *
from demographics_data
where location='Urban'
And
income > (select avg(income) from demographics_data);


--5. Count of Males and Females in Each Employment Status
select gender, employment_status, count(*) as total
from demographics_data
group by gender,employment_status


--6. Total and Average Income by Location and Occupation
-- Get total and average income per location and occupation
select  location, occupation,
sum(income) as total_income,
avg(income)as average_income
from
demographics_data
group by location,occupation;


--  7. Average Household Size by Housing Type
-- Calculate average household size per housing type
select type_of_housing, avg(household_size) as avg_house_hold
from
demographics_data
group by type_of_housing;


--8. Min, Max, Avg Work Experience by Marital Status
--- Summary statistics for work experience by marital status
select marital_status,
min(work_experience) as  min_exp,
max(work_experience) as  max_exp,
max(work_experience) as  avg_exp

from demographics_data
group by marital_status;


--9 Rank Individuals by Income Within Education Level
-- Rank individuals within their education level based on income
select *,
Rank() over (partition by education_level order by income desc) as  income_rank
from demographics_data;


--10. Top 3 Occupations by Highest Average Income
 -- Top 3 occupations with highest average income
select occupation,avg(income) as avg_income
from demographics_data
group by occupation
order by avg_income desc
limit 3;

--11. Cumulative Income by Gender
-- Calculate cumulative income per gender
select gender, income,
sum(income) over (partition by gender order by income ) cumulative_income 
from demographics_data;

--12. People Whose Income Is Above the Median
--- Find individuals earning above median income
with median_value as (
select percentile_cont(0.5) within group( order by income ) as median_income 
 from  demographics_data 
)
select *
from demographics_data,median_value
where income > median_income;

 













