SELECT COUNT(DISTINCT town) AS unique_town
from sghousingprice;

SELECT town,
AVG(resale_price) AS avg_resale_price
FROM sghousingprice
GROUP BY town
ORDER BY 2 desc;


SELECT town , flat_type , AVG(resale_price) AS avg_resale_price
FROM sghousingprice
GROUP BY town , flat_type;


CREATE VIEW test as
SELECT town , flat_type , AVG(resale_price) AS avg_resale_price
FROM sghousingprice
GROUP BY town , flat_type;

round(x::numeric,2)

select town,
         round(avg(case when (flat_type='1 ROOM') then avg_resale_price else NULL end):: numeric ,2) as "1 ROOM",
         round(avg(case when (flat_type='2 ROOM') then avg_resale_price else NULL end):: numeric ,2) as "2 ROOM",
         round(avg(case when (flat_type='3 ROOM') then avg_resale_price else NULL end):: numeric ,2) as "3 ROOM",
         round(avg(case when (flat_type='4 ROOM') then avg_resale_price else NULL end):: numeric ,2) as "4 ROOM",
         round(avg(case when (flat_type='5 ROOM') then avg_resale_price else NULL end):: numeric ,2) as "5 ROOM",
         round(avg(case when (flat_type='EXECUTIVE') then avg_resale_price else NULL end):: numeric ,2) as "EXECUTIVE",
         round(avg(case when (flat_type='MULTI-GENERATION') then avg_resale_price else NULL end):: numeric ,2) as "MULTI-GENERATION",
         round(avg(case when (flat_type='MULTI GENERATION') then avg_resale_price else NULL end):: numeric ,2) as "MULTI GENERATION"
         from test
         group by town
         order by town;
 
  