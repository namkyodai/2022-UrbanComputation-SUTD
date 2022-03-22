INSERT INTO productdata (orderdetailid, orderid, productid, quantity)
select orderdetailid, orderid, productid, quantity
From
orderdetails ;

update productdata 
set productname = products.productname
from products 
where products.productid = productdata.productid ;
	
update productdata 
set productname = products.productname,
	supllierid = products.supplierid,
	categoryid = products.categoryid,
	unit = products.unit ,
	price = products.price 
from products 
where products.productid = productdata.productid ;

update productdata 
set customerid  = orders.customerid,
	orderdate  = orders.orderdate,
	shiperid  = orders.shipperid 
from orders 
where orders.orderid  = productdata.orderid ;


update productdata 
set customername  = customers.customername ,
	customercontactname  = customers.contactname ,
	customeraddress  = customers.address  ,
	customercity = customers.city ,
	customerpostalcode = customers.postalcode ,
	customercountry =customers.country 
from customers 
where customers.customerid  = productdata.customerid ;


update productdata 
set shippername  = shippers.shippername,
	shipperphone   = shippers.phone
from shippers 
where shippers.shipperid  = productdata.shipperid ;


update productdata 
set suppliername  = suppliers.suppliername,
	suppliercontactname  = suppliers.contactname,
	supplieraddress  = suppliers.address,
	suppliercity  = suppliers.city,
	supplierpostalcode  = suppliers.postalcode,
	suppliercountry  = suppliers.country,
	supplierphone  = suppliers.phone 
from suppliers 
where suppliers.supplierid  = productdata.supllierid;

update productdata 
set categoryname  = categories.categoryname ,
	categorydescription  = categories.description  
from categories 
where categories.categoryid  = productdata.categoryid;
