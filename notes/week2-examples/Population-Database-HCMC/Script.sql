--ALTER TABLE communes ADD COLUMN area real;
--UPDATE communes SET area = ST_Area(geom::geography)/1609.34^2;

--select id as id, dientich_k as dientich, ST_Area(geom::geography)/1609.34^2 as area from communes;

DROP TABLE IF EXISTS hcmcforanalysis;
create table hcmcforanalysis
as 
select id as id, geom, c_nameen, p_nameen , d_nameen ,c_code ,p_code ,d_code ,ST_Area(geom,false)/1000000 as dientich, tongdanso_ as ds1999, tongdans00 as ds2005, 
tongdans01 as ds2009, danso_nam , (tongdans01 - danso_nam) as danso_nu, tongdans01/(ST_Area(geom,false)/1000000) as matdo, tongsoho, dhoc_daiho as daihoc, dhoc_thacs as thacsy, dhoc_tiens as tiensi
from communes;

DROP TABLE IF EXISTS hcmcforanalysis_nogeom;


create table hcmcforanalysis_nogeom
as 
select * from hcmcforanalysis;

ALTER TABLE hcmcforanalysis_nogeom 
DROP COLUMN c_nameen;

ALTER TABLE hcmcforanalysis_nogeom 
DROP COLUMN geom;