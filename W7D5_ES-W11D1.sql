/*1.Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria. 
Quali considerazioni/ragionamenti è necessario che tu faccia?*/
SELECT 
   ProductKey, COUNT(ProductKey) AS PK
FROM
    dimproduct
    Group by ProductKey;
-- La Colonna ProductKey per essere PK deve contenere solo valori univoci, cioè che non si ripetono.

/*2.Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK.*/
SELECT 
    SalesOrderNumber, SalesOrderLineNumber, COUNT(*) AS PK
FROM
    factresellersales
GROUP BY SalesOrderNumber , SalesOrderLineNumber;

/*3.Conta il numero transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020.*/
-- 4431 ROWS
SELECT 
    OrderDate, COUNT(distinct SalesOrderNumber) AS TransactionCount
FROM
    factresellersales AS frs
WHERE
    DATE(frs.OrderDate) >= '2020-01-01'
GROUP BY OrderDate;
 
/* 4.Calcola il fatturato totale (FactResellerSales.SalesAmount),la quantità totale venduta (FactResellerSales.OrderQuantity) 
e il prezzo medio di vendita (FactResellerSales.UnitPrice) per prodotto (DimProduct) a partire dal 1 Gennaio 2020.
Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, 
la quantità totale venduta e il prezzo medio di vendita.
I campi in output devono essere parlanti!*/
 
SELECT 
    dp.EnglishProductName AS Prodotto,
    frs.Orderdate,
    sum(frs.SalesAmount) AS Fatturato_Totale,
    sum(frs.OrderQuantity) AS Quantità_TOT_Venduta,
    AVG(frs.UnitPrice) AS Prezzo_Medio_di_Vendita
FROM
    factresellersales AS frs
        JOIN
    dimproduct AS dp ON dp.ProductKey = frs.ProductKey
        AND DATE(frs.OrderDate) >= '2020-01-01'
GROUP BY dp.EnglishProductName;


/*5.Calcola il fatturato totale (FactResellerSales.SalesAmount) e 
la quantità totale venduta (FactResellerSales.OrderQuantity) per Categoria prodotto (DimProductCategory). 
Il result set deve esporre pertanto il nome della categoria prodotto, il fatturato totale e la quantità totale venduta. 
I campi in output devono essere parlanti!*/

SELECT 
    dpc.EnglishProductCategoryName AS Categoria_Prodotto,
    sum(frs.SalesAmount) AS Fatturato_Totale,
    sum(frs.OrderQuantity) AS Quantità_TOT_Venduta
FROM
    factresellersales AS frs
       INNER JOIN
    dimproduct AS dp
        INNER JOIN
    dimproductcategory AS dpc
       INNER JOIN
    dimproductsubcategory AS dpsc ON frs.ProductKey = dp.ProductKey
        AND dpsc.ProductCategoryKey = dpc.ProductCategoryKey
        AND dp.ProductSubcategoryKey = dpsc.ProductSubcategoryKey
group by dpc.EnglishProductCategoryName;

/*6.Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020.
 Il result set deve esporre l’elenco delle città con fatturato realizzato superiore a 60K.*/
SELECT
   geo.City,
   sum(frs.SalesAmount) AS Fatturato_Totale
FROM 
   factresellersales as frs
    JOIN
   dimreseller as drs ON frs.ResellerKey = drs.ResellerKey
	JOIN
   dimgeography as geo ON drs.GeographyKey = geo.GeographyKey
WHERE 
DATE (frs.OrderDate) >= '2020-01-01'
GROUP BY geo.City
having sum(frs.SalesAmount) > 60000;
