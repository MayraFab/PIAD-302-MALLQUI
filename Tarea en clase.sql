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

-- CLASE DEL 28 DE AGOSTO DEL 2025

SELECT [CategoryID], [CategoryName] FROM Categories;

--1=
SELECT 'PIAD-302' FROM Categories
UNION
SELECT 'PIAD-302' FROM Categories

--2=
SELECT 'PIAD-302','PIAD-305' FROM Categories
UNION all
SELECT 'PIAD-303','PIAD-304' FROM Categories

--unir todas las filas, id y nombre de las tablas productos y categorias.
SELECT CategoryID, CategoryName FROM Categories
UNION all
SELECT ProductID, ProductName FROM Products

-- Consulta --Uso de INNER JOIN
SELECT * FROM Products as p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID

-- Mostrar el productID, ProductName, UnitPrice
SELECT p.ProductID, p.ProductName, p.UnitPrice, c.CategoryName FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID

--ORDERS Y CUSTOMERS --> INNER

SELECT c.CompanyName, c.ContactName, c.Phone, o.OrderDate, o.ShipName, ShipCity FROM Customers as c 
INNER JOIN Orders o ON c.CustomerID = o.CustomerID

--ORDERS Y ORDERS DETAILS --> INNER

SELECT od.UnitPrice, od.Quantity, od.Discount, o.OrderDate, o.ShipName, ShipCity FROM  Orders as o
INNER JOIN [Order Details] as od  ON od.OrderID = o.OrderID


-- TAREA EN CLASE

/*
1.- Mostrar el total de los "Orders" y agruparlos por CompanyName
Nota: Para calcular el total, obtienes de la tabla Order Details (Unit Price * Quantity)
Ejemplo:
Albert Futterkiste                        - 600
*/

SELECT c.CompanyName, od.OrderID,
SUM(od.UnitPrice*od.Quantity) as TotalOrder
FROM [Order Details] od
INNER JOIN Orders o ON od.OrderID = o.OrderID
INNER JOIN Customers as c ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName, od.OrderID
ORDER BY TotalOrder ASC;

/*
2.- Mostrar la cantidad de "Orders" agrupados por el nombre del empleado"
Ejemplo:
Janet 24
*/

SELECT e.FirstName, COUNT(o.OrderID) as TotalOrders
FROM Orders as o
INNER JOIN Employees as e ON o.EmployeeID = e.EmployeeID
GROUP BY e.FirstName
ORDER BY TotalOrders DESC;


