/*
1.Esponi l’anagrafica dei prodotti indicando per ciascun prodotto
anche la sua sottocategoria (DimProduct, DimProductSubcategory).
*/

SELECT 
    dp.ProductKey,
    dp.EnglishProductName,
    sc.EnglishProductSubcategoryName,
    dp.ProductSubcategoryKey,
    sc.ProductSubcategoryKey
FROM
    dimproduct AS dp
        JOIN
    dimproductsubcategory AS sc
    ON dp.ProductSubcategoryKey = sc.ProductSubcategoryKey;

/*
2.Esponi l’anagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria
e la sua categoria (DimProduct, DimProductSubcategory, DimProductCategory).
*/

SELECT 
    dp.ProductKey,
    dp.EnglishProductName,
    dpc.EnglishProductCategoryName,
    sc.EnglishProductSubcategoryName,
    dpc.ProductCategoryKey,
    sc.ProductCategoryKey,
    dp.ProductSubcategoryKey,
    sc.ProductSubcategoryKey
FROM
    dimproduct AS dp
        JOIN
    dimproductcategory AS dpc
        JOIN
    dimproductsubcategory AS sc
    ON dp.ProductSubcategoryKey = sc.ProductSubcategoryKey
    AND dpc.ProductCategoryKey = sc.ProductCategoryKey;

/*
3.Esponi l’elenco dei soli prodotti venduti (DimProduct, FactResellerSales).
*/

SELECT DISTINCT
    dp.ProductKey,
    dp.EnglishProductName
FROM
    dimproduct AS dp
       INNER JOIN
    factresellersales AS frs
    ON dp.ProductKey = frs.ProductKey;
-- si può fare anche con le subquery 
-- punto 3 con la subquery
SELECT DISTINCT
    dp.ProductKey, 
    dp.EnglishProductName
FROM
    dimproduct AS dp
WHERE
    dp.ProductKey IN (SELECT 
            frs.ProductKey
        FROM
            factresellersales AS frs);

/*
4.Esponi l’elenco dei prodotti non venduti (considera i soli prodotti finiti
cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1).*/
SELECT  
    dp.ProductKey, 
    dp.EnglishProductName,
    dp.FinishedGoodsFlag
FROM
    dimproduct AS dp
WHERE
dp.FinishedGoodsFlag=1
and
    dp.ProductKey NOT IN (SELECT 
            frs.ProductKey
        FROM
            factresellersales AS frs);
            

/*
5.Esponi l’elenco delle transazioni di vendita (FactResellerSales)
indicando anche il nome del prodotto venduto (DimProduct)
*/

SELECT
frs.SalesOrderNumber,
dp.EnglishProductName,
frs.SalesOrderLineNumber,
frs.OrderDate,
frs.OrderQuantity,
frs.SalesAmount
FROM factresellersales AS frs
INNER JOIN 
dimproduct AS dp
ON dp.ProductKey = frs.ProductKey;


/*
6.Esponi l’elenco delle transazioni di vendita indicando la categoria
di appartenenza di ciascun prodotto venduto.
*/

SELECT
dp.EnglishProductName as productname,
dpc.EnglishProductCategoryName as ProductCategoryName,
dpsc.EnglishProductSubcategoryName as ProductSubCategoryName,
dp.ProductKey,
frs.SalesOrderNumber,
frs.SalesOrderLineNumber,
frs.UnitPrice,
frs.OrderDate,
frs.OrderQuantity,
dp.ListPrice,
frs.TotalProductCost
FROM factresellersales AS frs
	 INNER JOIN 
     dimproduct AS dp
     INNER JOIN
     dimproductsubcategory AS dpsc
     INNER JOIN
     dimproductcategory AS dpc
ON dp.ProductKey = frs.ProductKey
AND dpsc.ProductCategoryKey = dpc.ProductCategoryKey
AND dpsc.ProductSubcategoryKey = dp.ProductSubcategoryKey;

/*
7.Esplora la tabella DimReseller.
*/

SELECT *
FROM dimreseller;

/*
8.Esponi in output l’elenco dei reseller indicando,
per ciascun reseller, anche la sua area geografica.
*/

SELECT
res.ResellerKey,
res.ResellerName,
geo.EnglishCountryRegionName as AreaGeografica,
geo.City
FROM dimreseller AS res
JOIN
dimgeography AS geo
ON geo.GeographyKey = res.GeographyKey;

/*
Esponi l’elenco delle transazioni di vendita. Il result set deve esporre i campi:
SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost.
Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto,
il nome del reseller e l’area geografica.*/

SELECT
fsr.SalesOrderNumber, 
fsr.SalesOrderLineNumber,
fsr.OrderDate,
fsr.UnitPrice, 
fsr.OrderQuantity, 
fsr.TotalProductCost,
dp.EnglishProductName,
dpc.EnglishProductCategoryname,
dpsc.EnglishProductSubcategoryName,
res.ResellerName,
geo.EnglishCountryRegionName
FROM factresellersales AS fsr
JOIN dimproduct AS dp
JOIN dimproductcategory AS dpc
JOIN dimproductsubcategory AS dpsc
JOIN dimreseller AS res
JOIN dimgeography AS geo
ON fsr.ProductKey = dp.ProductKey
AND dpsc.ProductCategoryKey = dpc.ProductCategoryKey
AND dp.ProductSubcategoryKey = dpsc.ProductSubcategoryKey
AND res.ResellerKey = fsr.ResellerKey
AND res.GeographyKey = geo.GeographyKey;