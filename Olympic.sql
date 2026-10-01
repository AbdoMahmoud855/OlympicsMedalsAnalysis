--Assign Number to each row.
select *,
Row_Number() over(order by s.year) as number
from dbo.summer as s
---------------------------------------------
--Assign Number to each year 
select *,
Row_Number() over(partition by s.YEAR order by  s.year ) as number
from dbo.summer as s
------------------------------------------------
---Retrieve Athlete Name, country and the number of medals they have won and Rank them by total medals 
select s.Athlete , s.Country,
COUNT(s.medal)as nMedals,
Row_Number() over(order by COUNT(s.medal) DESc) 
from summer as s
group by s.Athlete , s.Country
---------------------------------------------------------------------------
--Get the total number of medals each country won partition by year  “use Row_Number  
select s.year , s.Country,
COUNT(s.medal)as nMedals,
Row_Number() over(partition by s.year order by COUNT(s.medal) DESc) as rank_1
from summer as s
group by s.year, s.Country
order by nMedals desc

--------------------------------------------------------------------------------
--Based on the previous query find country with most medal in each year using CTE 
with Ranking_Country as (select s.year , s.Country,
COUNT(s.medal)as nMedals,
Row_Number() over(partition by s.year order by COUNT(s.medal) DESc) as rank_1
from summer as s
group by s.year, s.Country
)
select  country , nMedals,year
from Ranking_Country
where rank_1 = 1
order by Year 
--------------------------------------------------------------------------------
--Find athletes with most medals in each country 
with Ranking_Country as (
select s.Country, s.Athlete ,COUNT(s.medal)as nMedals,
row_number() over(partition by s.country order by COUNT(s.medal) desc) as RankMead
 from summer as s
group by s.Country, s.Athlete)
select country , Athlete
from Ranking_Country
where RankMead = 1
order by nMedals desc



