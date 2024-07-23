-- 1.Elencate il numero di tracce per ogni genere in ordine discendente, escludendo quei generi che hanno meno di 10 tracce.
SELECT
gn.Name,
gn.GenreId,
 count( tk.GenreId) as tracce_tot
FROM track as tk
JOIN genre as gn on gn.GenreId = tk.GenreId
GROUP BY gn.Name, gn.GenreId
HAVING tracce_tot >= 10
order by tracce_tot desc;

-- 2.Trovate le tre canzoni più costose (più vendute)
SELECT
tk.Name as canzone,
tk.UnitPrice
FROM track AS tk
order by tk.UnitPrice desc
limit 3;

-- 3.Elencate gli artisti che hanno canzoni più lunghe di 6 minuti.
SELECT distinct
    art.Name
FROM
    track AS tk
        JOIN
    album AS alb ON alb.AlbumId = tk.AlbumId
        JOIN
    artist AS art ON art.ArtistId = alb.ArtistId
WHERE
    tk.Milliseconds > 360000;
    
   -- 4. Individuate la durata media delle tracce per ogni genere.
    SELECT 
    gn.Name,
    avg(tk.Milliseconds) as durata_media_tracce
FROM track as tk
JOIN genre as gn on gn.GenreId = tk.GenreId
GROUP BY gn.Name;
    
 -- 5.Elencate tutte le canzoni con la parola “Love” nel titolo, ordinandole alfabeticamente prima per genere e poi per nome.   
SELECT 
    gn.Name AS Genere, tk.Name AS Titolo_Canzone
FROM
    track AS tk
        JOIN
    genre AS gn ON gn.GenreId = tk.GenreId
GROUP BY tk.Name , gn.Name
HAVING Titolo_Canzone LIKE '%Love%'
ORDER BY gn.Name ASC , tk.Name ASC;  

-- 6.Trovate il costo medio per ogni tipologia di media.
SELECT distinct
    mt.Name, AVG(tk.UnitPrice) AS costomedio_mediatype
FROM
    track AS tk
        JOIN
    mediatype AS mt ON mt.MediaTypeId = tk.MediaTypeId
GROUP BY mt.Name;

-- 7.Individuate il genere con più tracce.
SELECT 
    gn.Name, COUNT(tk.TrackId) AS n_tracce
FROM
    track AS tk
        JOIN
    genre AS gn ON gn.GenreId = tk.GenreId
GROUP BY gn.name
ORDER BY n_tracce DESC
LIMIT 1;

-- 8. Trovate gli artisti che hanno lo stesso numero di album dei Rolling Stones.
SELECT 
    art.NAME AS Artista, COUNT(alb.Title) AS Numero_Album
FROM
    album AS alb
        LEFT JOIN
    artist AS art ON alb.ArtistId = art.ArtistId
GROUP BY art.NAME
HAVING Numero_Album = (SELECT 
        COUNT(alb.Title) AS Numero_Album
    FROM
        album AS alb
            LEFT JOIN
        artist AS art ON alb.ArtistId = art.ArtistId
    WHERE
        art.NAME = 'The Rolling Stones');

-- 9.Trovate l’artista con l’album più costoso.

SELECT 
art.NAME as Artista, 
alb.Title as Titolo_Album,
sum(tk.UnitPrice) AS Prezzo_Album
FROM track as tk
inner JOIN album as alb ON tk.AlbumId = alb.AlbumId
inner JOIN artist as art ON alb.AlbumId = art.ArtistId
GROUP BY art.NAME, alb.Title
order by Prezzo_Album desc
limit 1;
