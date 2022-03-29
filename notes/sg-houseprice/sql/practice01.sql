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



select '1 ROOM', '2 ROOM' , '3 ROOM' , '4 ROOM' , '5 ROOM' , 'EXECUTIVE', 'MULTI-GENERATION', 'MULTI GENERATION'
from
(
select value, flat_type
from sghousingprice
) 
pivot
(
max(value)
for columnname in ('1 ROOM', '2 ROOM' , '3 ROOM' , '4 ROOM' , '5 ROOM' , 'EXECUTIVE', 'MULTI-GENERATION', 'MULTI GENERATION')
) piv;



CREATE VIEW test as
SELECT town , flat_type , AVG(resale_price) AS avg_resale_price
FROM sghousingprice
GROUP BY town , flat_type;


select town,
         avg(case when (flat_type='1 ROOM') then avg_resale_price else NULL end) as "1 ROOM",
         avg(case when (flat_type='2 ROOM') then avg_resale_price else NULL end) as "2 ROOM",
         avg(case when (flat_type='3 ROOM') then avg_resale_price else NULL end) as "3 ROOM",
         avg(case when (flat_type='4 ROOM') then avg_resale_price else NULL end) as "4 ROOM",
         avg(case when (flat_type='5 ROOM') then avg_resale_price else NULL end) as "5 ROOM",
         avg(case when (flat_type='EXECUTIVE') then avg_resale_price else NULL end) as "EXECUTIVE",
         avg(case when (flat_type='MULTI-GENERATION') then avg_resale_price else NULL end) as "MULTI-GENERATION",
         avg(case when (flat_type='MULTI GENERATION') then avg_resale_price else NULL end) as "MULTI GENERATION"
         from test
         group by town
         order by town;
 
  