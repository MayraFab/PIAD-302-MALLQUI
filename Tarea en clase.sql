SELECT * FROM Customers;


-- Uso de Wildcards
SELECT * FROM Customers
WHERE CustomerID LIKE 'A%'

SELECT * FROM Customers
WHERE CustomerID LIKE '%N'

SELECT * FROM Customers
WHERE CustomerID LIKE 'AN___'

SELECT * FROM Customers
WHERE CustomerID LIKE '[^C]%'

-- EJERCICIOS PARTE I
/*
1.- Mostrar todos los "Customers" que tengan una dirección de "Av".
2.- Mostrar todos los "Customers" que no pertenezcan al país "Brasil".
3.- Mostrar todos los "Customers" que no tengan una región "NULL" y que el fax no sea "NULL".
*/

-- RESPUESTAS PARTE I
/* 1 */
SELECT * FROM Customers
WHERE Address LIKE '%Av%'

/* 2 */
SELECT * FROM Customers
WHERE Country LIKE '[^B]%'

/* 3 */
SELECT * FROM Customers
WHERE Region IS NOT NULL AND Fax IS NOT NULL



-- Uso del In
SELECT * FROM Employees
WHERE TitleOfCourtesy IN ('Ms.','Mr.','Mrs.')

-- Mostrar a los "Employees" que sean de la ciudad "Seattle, Tacna, Redmond"
SELECT * FROM Employees
WHERE City IN ('Seattle','Tacna','Redmond')

-- Uso de Group By
SELECT City, COUNT(*) 'Cantidad' FROM Customers
GROUP BY City
ORDER BY COUNT(*) DESC

-- Contar los registros
SELECT COUNT(*) FROM Customers;

-- Sumar los precios Unitarios
SELECT SUM(UnitPrice) FROM Products;

--Promedio de los precios
SELECT AVG(UnitPrice) FROM Products;




-- PREGUNTAS PARTE 2
/*
4.- Contar todas las "Orders" agrupando por el "ShipCountry"
5.- Contar todas las "Orders" agrupando por el "ShipCity"
6.- Sumar todos los "UnitPrice" de los "Products" agrupando por "CategoryId" 
*/

-- RESPUESTAS PARTE 2
/* 4 */
SELECT ShipCountry, COUNT(*) 'Cantidad' FROM Orders
GROUP BY ShipCountry
ORDER BY COUNT(*) DESC 

/* 5 */
SELECT ShipCity, COUNT(*) 'Cantidad' FROM Orders
GROUP BY ShipCity
ORDER BY COUNT(*) ASC 

/* 6 */ 
SELECT CategoryID, SUM(UnitPrice)  FROM Products
GROUP BY CategoryID