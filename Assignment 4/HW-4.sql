SELECT CompanyName, Country FROM hwSuppliers WHERE Country IN ('Japan', 'Germany');
SELECT ProductName, QuantityPerUnit, UnitPrice FROM hwProducts WHERE UnitPrice < 7 AND UnitPrice >  4;
SELECT CompanyName, ContactTitle, City FROM hwCustomers WHERE  Country = 'USA' AND City = 'Portland' OR Country = 'Canada' AND City = 'Vancouver'; 
SELECT ContactName, ContactTitle FROM hwSuppliers WHERE SupplierID >= 5 AND SupplierID <= 8 ORDER BY SupplierID DESC;
SELECT ProductName, UnitPrice FROM hwProducts WHERE UnitPrice =(SELECT MIN(UnitPrice) FROM hwProducts);
SELECT COUNT(ShipCountry) FROM hwOrders WHERE NOT 'USA' AND ShippedDate BETWEEN '2015-04-05' AND '2015-05-05';
SELECT FirstName, LastName, DATE_FORMAT(HireDate, '%m/%d/%Y') AS DateHired FROM hwEmployees WHERE NOT Country = 'USA' AND HireDate >= YEAR(CURRENT_TIMESTAMP) - 5;
SELECT ProductName, (UnitsInStock * UnitPrice) AS 'Inventory Value' FROM hwProducts WHERE (UnitsInStock * UnitPrice) BETWEEN 3000 and 4000 ;
SELECT ProductName, UnitsInStock, ReorderLevel FROM hwProducts WHERE (ProductName LIKE 'S%') AND (UnitsInStock > 0) AND (UnitsInStock <= ReorderLevel);
SELECT ProductName, UnitPrice FROM hwProducts WHERE Discontinued = 1;
SELECT hwProducts.ProductName, (hwProducts.UnitsInStock * hwProducts.UnitPrice) AS InventoryValue FROM hwProducts INNER JOIN hwSuppliers ON hwProducts.SupplierID = hwSuppliers.SupplierID WHERE hwSuppliers.Country = 'Japan';
SELECT Country, COUNT(Country) FROM hwCustomers GROUP BY Country HAVING COUNT(Country) > 8;
SELECT hwOrders.ShipCountry, hwOrders.ShipCity, COUNT(OrderID) FROM hwOrders GROUP BY hwOrders.ShipCountry, hwOrders.ShipCity HAVING hwOrders.ShipCountry = 'Austria' OR hwOrders.ShipCountry = 'Argentina'; 
SELECT CompanyName, ProductName FROM hwSuppliers, hwProducts WHERE hwSuppliers.Country = 'Spain';
SELECT CAST(AVG(UnitPrice) AS DECIMAL(10,2)) AS AverageUnitPrice FROM hwProducts WHERE (ProductName LIKE '%T');
SELECT CONCAT(FirstName,' ',LastName) AS FullName, Title, COUNT(OrderID) FROM hwEmployees, hwOrders GROUP BY FirstName, LastName, Title HAVING COUNT(OrderID) > 120;
SELECT hwCustomers.CompanyName, hwCustomers.Country FROM hwCustomers INNER JOIN hwOrders ON hwCustomers.customerID=hwOrders.OrderID WHERE hwOrders.orderID IS NULL;
SELECT CategoryName, ProductName FROM hwCategories, hwProducts WHERE UnitsInStock = 0;
SELECT ProductName, QuantityPerUnit FROM hwProducts, hwSuppliers WHERE (QuantityPerUnit LIKE '%pkg%' OR QuantityPerUnit LIKE '%pkgs%' OR QuantityPerUnit LIKE '%jar%') AND Country = 'Japan';
SELECT hwCustomers.CompanyName, hwOrders.ShipName, CAST((hwOrderDetails.UnitPrice * hwOrderDetails.Quantity) AS DECIMAL (10,2)) AS TotalValue FROM hwCustomers, hwOrders, hwOrderDetails WHERE hwOrders.OrderID = hwOrders.OrderID AND hwCustomers.Country = 'Mexico';
SELECT ProductName, Region FROM hwProducts, hwSuppliers WHERE (ProductName LIke 'L%') AND (Region <>'');
SELECT ShipCountry, ShipName, OrderDate, DATE_FORMAT(OrderDate, '%M/%Y') AS DateOfOrder From hwOrders WHERE ShipCity = 'Versailles';SELECT ProductName, UnitsInStock, RANK() OVER (ORDER BY UnitsInStock DESC) FROM hwProducts WHERE (ProductName LIKE 'F%');
SELECT ProductName, UnitPrice, RANK() OVER (ORDER BY UnitPrice ASC) FROM hwProducts WHERE ProductID >=1 AND ProductID <= 5;
SELECT FirstName, LastName, Country, DATE_FORMAT(BirthDate, '%m/%d/%Y') AS DOB, RANK() OVER (PARTITION BY Country ORDER BY BirthDate ASC) BirthOrder FROM hwEmployees WHERE BirthDate >= 19840000;
 
 
 
