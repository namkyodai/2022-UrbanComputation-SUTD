UPDATE 
   example 
SET 
   field_key  = REPLACE (
  	field_key ,
	'C',
	'C1'
   );
   
  UPDATE 
   example 
SET 
   field_key  = REPLACE (
  	field_key ,
	'C',
	'C1'
   )
   where id = 1;
 
  