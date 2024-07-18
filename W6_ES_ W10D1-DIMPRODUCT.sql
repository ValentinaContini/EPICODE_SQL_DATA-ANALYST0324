-- Esplora la tabella dei prodotti(DimProduct)
SELECT * FROM AdventureWorksDW.dimproduct;
/*Interroga la tabella dei prodotti (DimProduct) 
ed esponi in output i campi ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, FinishedGoodsFlag. 
Il result set deve essere parlante per cui assegna un alias se lo ritieni opportuno*/
SELECT 
    ProductKey,
    ProductAlternatekey,
    EnglishProductName,
    Color,
    StandardCost,
    FinishedGoodsFlag
FROM
    dimproduct;
/*Partendo dalla query scritta nel passaggio precedente, 
esponi in output i soli prodotti finiti cioè quelli per cui il campo FinishedGoodsFlag è uguale a 1*/
SELECT 
    ProductKey,
    ProductAlternatekey,
    EnglishProductName,
    Color,
    StandardCost,
    FinishedGoodsFlag
FROM
    dimproduct
WHERE     
    FinishedGoodsFlag=1
AND Color= 'Red'    ;
/*Scrivi una nuova query al fine di esporre in output i prodotti il cui codice modello (ProductAlternateKey) comincia con FR oppure BK.
 Il result set deve contenere il codice prodotto (ProductKey), il modello, 
 il nome del prodotto, il costo standard (StandardCost) e il prezzo di listino (ListPrice).*/
 SELECT 
    ProductKey,
    ProductAlternatekey,
    ModelName,
    EnglishProductName,
    StandardCost,
    ListPrice
FROM
    dimproduct
WHERE
    ProductAlternatekey LIKE 'FR%'
        OR ProductAlternatekey LIKE 'BK%';
        
-- Arricchisci il risultato della query scritta nel passaggio precedente del Markup applicato dall’azienda (ListPrice - StandardCost)     
SELECT 
    ProductKey,
    ProductAlternatekey,
    ModelName,
    EnglishProductName,
    StandardCost,
    ListPrice,
    ListPrice-StandardCost as Markup
FROM
    dimproduct
WHERE
    ProductAlternatekey LIKE 'FR%'
        OR ProductAlternatekey LIKE 'BK%';


/*Scrivi un’altra query al fine di esporre l’elenco dei prodotti finiti
 il cui prezzo di listino è compreso tra 1000 e 2000.*/
SELECT 
    ProductKey,
    ProductAlternatekey,
    EnglishProductName,
    Color,
    StandardCost,
    FinishedGoodsFlag,
    ListPrice
FROM
    dimproduct
WHERE
    FinishedGoodsFlag = 1
        AND ListPrice BETWEEN 1000 AND 2000
ORDER BY ListPrice desc;

/*aggiungiamo noi filtri
filtro colori, condizione col in*/
SELECT 
    ProductKey,
    ProductAlternatekey,
    EnglishProductName,
    Color,
    StandardCost,
    FinishedGoodsFlag,
    ListPrice
FROM
    dimproduct
WHERE
    FinishedGoodsFlag = 1
        AND ListPrice BETWEEN 1000 AND 2000
        and color in ('Red','Black','Yellow')
ORDER BY ListPrice desc;
