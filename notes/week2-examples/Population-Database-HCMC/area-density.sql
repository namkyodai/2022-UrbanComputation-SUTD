select id as id, geom, ST_Area(geom,false)/1000000 as area, tongdans01/(ST_Area(geom,false)/1000000) as density 
from communes