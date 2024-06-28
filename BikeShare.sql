--Calculating Revenue and profit
With cte as (
Select* from bike_share_yr_0
Union
Select* from bike_share_yr_1)

Select
dteday, hr, season, bks.yr,
weekday,rider_type,riders,
price,COGS,
riders*price as revenue,
riders*price -COGS*riders as profit
from cte bks
Left join cost_table ct
on bks.yr= ct.yr


--Calculating Total and Average Revenue for 2021 and 2022
With cte as (
Select* from bike_share_yr_0
Union
Select* from bike_share_yr_1)

Select Round(Sum(riders*price),2) as Total_Revenue, 
Round(Avg(riders*price),2) as Avg_Revenue, 
Round(Avg(Price),2) as Avg_Price,
Round(Sum(riders*price -COGS*riders),2) as Total_Profit, 
Round(Avg(riders*price -COGS*riders),2) as Avg_Profit, 
bks.yr,
CASE
WHEN bks.yr = 0 THEN 2021
WHEN bks.yr = 1 THEN 2022
Else 'Null'
END as Years
from cte bks
Left join cost_table ct
on bks.yr= ct.yr
Group by bks.yr


--Calculating Revenue and profit by Seasons
With cte as (
Select* from bike_share_yr_0
Union
Select* from bike_share_yr_1)

Select 
Round(Sum(riders*price),2) as Revenue, 
Round(Sum(riders*price -COGS*riders),2) as Profit, season
from cte bks
Left join cost_table ct
on bks.yr= ct.yr
Group by season
 Order by Revenue desc


 
--Calculating No of Casual vs Registered Riders
With cte as (
Select* from bike_share_yr_0
Union
Select* from bike_share_yr_1)

Select rider_type, SUM(riders) as No_of_Riders
from cte bks
Left join cost_table ct
on bks.yr= ct.yr
Group by Rider_type
Order by No_of_Riders Desc



--Calculating no of riders 2021 vs 2022
With cte as (
Select* from bike_share_yr_0
Union
Select* from bike_share_yr_1)

Select Sum(riders) as riders, bks.yr,
CASE
WHEN bks.yr = 0 THEN 2021
WHEN bks.yr = 1 THEN 2022
Else 'Null'
END as Years
from cte bks
Left join cost_table ct
on bks.yr= ct.yr
group by bks.yr
Order by riders desc 