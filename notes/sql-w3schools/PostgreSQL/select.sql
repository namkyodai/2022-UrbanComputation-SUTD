SELECT * FROM Customers;
SELECT CustomerName, City FROM Customers;
SELECT Country FROM Customers;

SELECT DISTINCT Country FROM Customers;

SELECT COUNT(*) FROM Customers;
SELECT COUNT(DISTINCT Country) FROM Customers;


SELECT * FROM Customers
WHERE Country='Mexico';

SELECT * FROM Customers
WHERE CustomerID=1;

SELECT * FROM Customers
WHERE City LIKE 'S%';

SELECT * FROM Customers
WHERE City IN ('Paris','London');

SELECT * FROM Customers
WHERE Country='Germany' AND City='Berlin';

SELECT * FROM Customers
WHERE City='Berlin' OR City='München';

SELECT * FROM Customers
WHERE Country='Germany' OR Country='Spain';

SELECT * FROM Customers
WHERE NOT Country='Germany';


SELECT * FROM Customers
WHERE Country='Germany' AND (City='Berlin' OR City='München');

SELECT * FROM Customers
WHERE NOT Country='Germany' AND NOT Country='USA';


SELECT * FROM Customers
ORDER BY Country;

SELECT * FROM Customers
ORDER BY Country DESC;

SELECT * FROM Customers
ORDER BY Country, CustomerName;

SELECT * FROM Customers
ORDER BY Country ASC, CustomerName DESC;



