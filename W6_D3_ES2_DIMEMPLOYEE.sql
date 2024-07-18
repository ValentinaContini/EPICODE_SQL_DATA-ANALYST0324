-- Esplora la tabella degli impiegati (DimEmployee)
SELECT * FROM AdventureWorksDW.dimemployee;

/*Esponi, interrogando la tabella degli impiegati aziendali, l’elenco dei soli agenti. 
Gli agenti sono i dipendenti per i quali il campo SalespersonFlag è un 1.*/
SELECT 
    *
FROM
    dimemployee
WHERE
    SalesPersonFlag = 1;
      
/*Interroga la tabella delle vendite (FactResellerSales).*/
Select*from factresellersales;

/*Esponi in uscita l’elenco delle transazioni registrate a partire dal 1 gennaio 2020 dei soli codici prodotto: 
597, 598, 477, 214. Calcola per ciascuna transazione il transazione il profitto (SalesAmount - TotalProductCost).*/
SELECT 
SalesOrderNumber,
OrderDate,
ProductKey,
(SalesAmount-TotalProductCost) as 'Profit'
 FROM
  factresellersales
WHERE 
DATE (factresellersales.OrderDate) >= '2020-01-01'
AND ProductKey in (597, 598, 477, 214);
   