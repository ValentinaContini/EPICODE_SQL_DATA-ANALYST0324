/*1.1Identificate tutti i clienti che non hanno effettuato nessun noleggio a gennaio 2006.*/
SELECT 
    *
FROM
    customer AS C
WHERE
    C.customer_id NOT IN (SELECT DISTINCT
            customer_id
        FROM
            rental
        WHERE
            YEAR(rental_date) = '2006'
                AND MONTH(rental_date) = 01);

/*2.Elencate tutti i film che sono stati noleggiati più di 10 volte nell’ultimo quarto del 2005.*/
SELECT 
f.film_id as filmID,
f.title as titolo_film,
count(rtl.rental_id) as total_noleggi
FROM
    film AS f
        JOIN
    inventory AS invt ON f.film_id = invt.film_id
        JOIN
        customer AS c ON invt.store_id = c.store_id
        join
    rental AS rtl ON c.customer_id = rtl.customer_id
WHERE 
quarter(rental_date)=1 and year(rental_date)= '2006'
group by filmID, titolo_film;


/*4.Calcolate la somma degli incassi generati nei weekend (sabato e domenica).*/
SELECT
sum(amount) as incassi_weekend
FROM rental as rtl
join payment as p on rtl.rental_id = p.rental_id
where dayofweek(payment_date)=1 or dayofweek(payment_date)=7;

/* 5.Individuate il cliente che ha speso di più in noleggi.*/
SELECT 
    c.first_name AS nome,
    c.last_name AS cognome,
    SUM(p.amount) AS tot_speso
FROM
    rental AS rtl
        JOIN
    payment AS p ON rtl.rental_id = p.rental_id
        JOIN
    customer AS c ON c.customer_id = p.customer_id
GROUP BY nome , cognome
ORDER BY tot_speso DESC
LIMIT 1;

/*6.Elencate i 5 film con la maggior durata media di noleggio.*/
SELECT 
    title AS titolo_film, AVG(rental_duration) AS noleggio_medio
FROM
    film
GROUP BY titolo_film
LIMIT 5;
-- metodo alternativo
SELECT 
    title, rental_duration AS durata
FROM
    film
ORDER BY 2 DESC
LIMIT 5;

/*7Calcolate il tempo medio tra due noleggi consecutivi da parte di un cliente.*/
SELECT 
    CUSTOMER_ID, AVG(DIFFERENZA_NOLEGGI_CONSECUTIVI)
FROM
    (SELECT DISTINCT
        A.*,
            RR1.RENTAL_DATE AS DATA_NOLEGGIO_PRECEDENTE,
            RR2.RENTAL_DATE AS DATA_NOLEGGIO_SUCCESSIVO,
            DATEDIFF(RR2.RENTAL_DATE, RR1.RENTAL_DATE) DIFFERENZA_NOLEGGI_CONSECUTIVI
    FROM
        (SELECT 
        r1.customer_id,
            r1.rental_id,
            MIN(r2.rental_id) AS NOLEGGIO_SUCCESSIVO
    FROM
        rental r1
    LEFT JOIN rental r2 ON r1.customer_id = r2.customer_id
        AND r2.rental_id > r1.rental_id
    WHERE
        r1.customer_id = 1
            AND r2.customer_id = 1
    GROUP BY r1.customer_id , r1.rental_id) A
    LEFT JOIN RENTAL RR1 ON A.CUSTOMER_ID = RR1.CUSTOMER_ID
        AND A.RENTAL_ID = RR1.RENTAL_ID
    LEFT JOIN RENTAL RR2 ON A.CUSTOMER_ID = RR2.CUSTOMER_ID
        AND A.NOLEGGIO_SUCCESSIVO = RR2.RENTAL_ID) AA
GROUP BY CUSTOMER_ID;

/*8.Individuate il numero di noleggi per ogni mese del 2005.*/
SELECT 
    COUNT(rtl.rental_id) AS N_Noleggi,
    MONTHNAME(rtl.rental_date) AS mese,
    YEAR(rental_date) AS anno
FROM
    rental AS rtl
WHERE
    YEAR(rental_date) IN (2005)
GROUP BY mese , anno;

/*9.Trovate i film che sono stati noleggiati almeno due volte lo stesso giorno.*/
SELECT 
    f.title AS titolo_film,
    COUNT(rental_date) AS n1,
    COUNT(DISTINCT DATE(rental_date)) AS n2
FROM
    rental AS rtl
        JOIN
    inventory AS inv ON rtl.inventory_id = inv.inventory_id
        JOIN
    film AS f ON inv.film_id = f.film_id
GROUP BY 1
HAVING n1 <> n2
ORDER BY 1;

/*10.Calcolate il tempo medio di noleggio*/
SELECT 
    AVG(rental_duration) AS tempo_medio_noleggio
FROM
    film;

