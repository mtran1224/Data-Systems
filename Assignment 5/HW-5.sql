#Michelle Tran
#HW-5


USE HW_5_DW;

#Question 1
SELECT a.CustomerName, a.Gender, b.SalesPersonName, b.City 
FROM Fact_ProductSales d
INNER JOIN Dim_Customer a ON a.CustomerID = d.CustomerID
INNER JOIN Dim_SalesPerson b ON b.SalesPersonID = d.SalesPersonID 
INNER JOIN Dim_Date c ON c.DateKey = d.SalesDateKey
WHERE c.MONTHNAME = 'September' AND c.YEAR = '2015' AND d.SalesPrice > 20 AND d.Quantity > 8;

#Question 2
SELECT a.StoreName, a.City, b.ProductName
FROM Fact_ProductSales d
INNER JOIN Dim_Store a ON a.StoreID = d.StoreID
INNER JOIN Dim_Product b ON b.ProductKey = d.ProductID
INNER JOIN Dim_Date c ON c.DateKey = d.SalesDateKey
WHERE c.MONTHNAME = 'March' and c.YEAR = '2017'
AND d.ProductCost < 50 AND a.City = 'Boulder';



#Question 3
SELECT e.SalesPersonName, Sum(e.TotalRevenue) AS Top2SalesRevenue 
FROM(SELECT b.SalesPersonName, a.ProductID, ((Sum(a.Quantity)) * a.SalesPrice) AS TotalRevenue
FROM Fact_ProductSales a
INNER JOIN Dim_SalesPerson b ON a.SalesPersonID = b.SalesPersonID
INNER JOIN Dim_Date c ON c.DateKey = a.SalesDateKey
WHERE c.YEAR = 2017
GROUP BY a.SalesPersonID, b.SalesPersonName, a.ProductID, a.Quantity, a.SalesPrice) e
GROUP BY e.SalesPersonName
ORDER BY Top2SalesRevenue Desc
LIMIT 2;


#Question 4
SELECT e.CustomerName, Sum(e.TotalRevenue) AS LowestTotalRevenue 
FROM(SELECT b.CustomerName, a.ProductID, ((Sum(a.Quantity)) * a.SalesPrice) AS TotalRevenue
FROM Fact_ProductSales a
INNER JOIN Dim_Customer b ON a.CustomerID = b.CustomerID
INNER JOIN Dim_Date c ON c.DateKey = a.SalesDateKey
WHERE c.YEAR = 2017
GROUP BY a.CustomerID, b.CustomerName, a.ProductID, a.Quantity, a.SalesPrice) e
GROUP BY e.CustomerName
ORDER BY LowestTotalRevenue
LIMIT 1;

#Question 5
SELECT e.StoreName, Sum(e.Total_Sales_Price) AS 'Total Sales Price' 
FROM(SELECT a.StoreName, c.ProductID, ((Sum(c.Quantity)) * c.SalesPrice) AS Total_Sales_Price
FROM Fact_ProductSales c
INNER JOIN Dim_Store a ON a.StoreID = c.StoreID 
INNER JOIN Dim_Date b ON b.DateKey = c.SalesDateKey
WHERE b.YEAR BETWEEN '2010' AND '2017'
GROUP BY c.StoreID, a.StoreName, c.ProductID, c.SalesPrice, c.Quantity) e
GROUP BY e.StoreName
ORDER BY e.StoreName;

#Question 6
SELECT b.StoreName,a.ProductName,SUM((c.SalesPrice * c.Quantity)-(c.ProductCost * c.Quantity)) AS TotalProfit
FROM  Fact_ProductSales c
INNER JOIN Dim_Product a ON c.ProductID=a.ProductKey
INNER JOIN Dim_Store b ON b.StoreID = c.StoreID 
INNER JOIN Dim_Date d ON c.SalesDateKey=d.DateKey
WHERE a.ProductName LIKE '%Jasmine Rice%'
AND D.YEAR= 2010
GROUP BY b.StoreName,a.ProductName;

#Question 7 
SELECT c.QUARTER, (SUM(SalesPrice*Quantity)) AS TotalRevenue
FROM Fact_ProductSales b
INNER JOIN Dim_Store a ON b.StoreID=a.StoreID 
INNER JOIN Dim_Date c  ON b.SalesDateKey=c.DateKey
WHERE a.StoreName='ValueMart Boulder' AND c.YEAR='2016'
GROUP BY c.QUARTER
ORDER BY c.QUARTER ASC;



#Question 8
SELECT a.CustomerName,SUM(SalesPrice*Quantity) AS TotalSales
FROM Dim_Customer a,Fact_ProductSales b 
WHERE a.CustomerName='Melinda Gates' OR a.CustomerName='Harrison Ford'
GROUP BY a.CustomerName;


#Question 9 
SELECT a.StoreName, b.SalesPrice, b.Quantity
FROM Fact_ProductSales b 
INNER JOIN Dim_Store a ON b.StoreID=a.StoreID
INNER JOIN Dim_Date c ON b.SalesDateKey=c.DateKey
WHERE c.Date = '2017-03-12';



#Question 10
SELECT SP.SalesPersonName, SUM(P.SalesPrice*P.Quantity) AS TotalRevenue
FROM Dim_SalesPerson SP JOIN fact_productsales P ON
SP.SalesPersonID = P.SalesPersonID 
GROUP BY SP.SalesPersonID
ORDER BY TotalRevenue DESC LIMIT 1;

#Question 11
SELECT a.ProductName, SUM(((b.SalesPrice * b.Quantity) - (b.ProductCost * b.Quantity))) AS TotalProfit
FROM Fact_ProductSales b 
JOIN Dim_Product a on b.ProductID = a.ProductKey
GROUP BY a.ProductKey
ORDER BY TotalProfit DESC LIMIT 3;


#Question 12
SELECT a.Year, a.MonthName, Sum(b.SalesPrice * b.Quantity) AS TotalRevenue
FROM Fact_ProductSales b
INNER JOIN Dim_Date a ON b.SalesDatekey = a.DateKey 
GROUP BY a.Year, a.MonthName 
HAVING a.MonthName IN('January', 'February' , 'March') and year = '2017';

#Question 13
SELECT a.ProductName , Round(AVG(b.ProductCost),2) AS AvgCost, Round(AVG(b.SalesPrice),2) AS AvgSales
FROM Dim_Product a
INNER JOIN Fact_ProductSales b ON a.ProductKey = b.ProductID 
INNER JOIN Dim_Date c ON b.SalesDatekey = c.DateKey
WHERE c.YEAR = 2017 
GROUP BY a.ProductName;


#Question 14
SELECT a.CustomerName, Round(Avg(b.SalesPrice), 2) AS AvgSales, Round(Avg(b.Quantity), 2) AS AvgQuantity 
FROM Dim_Customer a
INNER JOIN Fact_ProductSales b on a.CustomerID = b.CustomerID 
GROUP BY a.CustomerName HAVING a.CustomerName = 'Melinda Gates';


#Question 15
SELECT a.StoreName, Round(Max(b.SalesPrice),2) AS MaxSales, Round(Min(b.SalesPrice),2) AS MinSales 
FROM Dim_Store a
INNER JOIN Fact_ProductSales b ON a.StoreID = b.StoreID 
WHERE a.City = 'Boulder'
GROUP BY a.StoreName;

