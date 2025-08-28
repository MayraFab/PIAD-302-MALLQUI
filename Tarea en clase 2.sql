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

