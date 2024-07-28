/* 1.Recuperate tutte le tracce che abbiano come genere “Pop” o “Rock”.*/
SELECT 
    tk.Name AS nome_traccia, ge.Name AS genere
FROM
    track AS tk
        JOIN
    genre AS ge ON tk.GenreId = ge.GenreId
WHERE
    ge.Name IN ('POP' , 'ROCK');

/*2.Elencate tutti gli artisti e/o gli album che inizino con la lettera “A”.*/
SELECT 
    art.Name AS nome_artista, alb.Title AS album
FROM
    artist AS art
        LEFT JOIN
    album AS alb ON art.ArtistId = alb.ArtistId
WHERE
    art.Name LIKE 'A%'
        OR alb.Title LIKE 'A%';

/*3.Elencate tutte le tracce che hanno come genere “Jazz” o che durano meno di 3 minuti.*/
SELECT 
    tk.Name AS nome_traccia, ge.Name AS genere, tk.Milliseconds
FROM
    track AS tk
        JOIN
    genre AS ge ON tk.GenreId = ge.GenreId
WHERE
    ge.Name = 'JAZZ'
        OR tk.Milliseconds < 180000;
-- 3min = 180000ms

/*4. tutte le tracce più lunghe della durata media*/
SELECT 
    tk.Name AS nome_traccia, tk.Milliseconds
FROM
    track AS tk
WHERE
    tk.Milliseconds > (SELECT 
            AVG(Milliseconds)
        FROM
            track);

/*5.Individuate i generi che hanno tracce con una durata media maggiore di 4 minuti.*/
SELECT 
    ge.Name AS Genere
FROM
    track AS tk
        JOIN
    genre AS ge ON tk.GenreId = ge.GenreId
GROUP BY ge.Name
HAVING AVG(tk.Milliseconds) > 240000;

/*6.Individuate gli artisti che hanno rilasciato più di un album.*/
SELECT 
    art.Name AS nome_artista, COUNT(alb.AlbumId) AS n_album
FROM
    artist AS art
        JOIN
    album AS alb ON art.ArtistId = alb.ArtistId
GROUP BY art.Name
HAVING n_album > 1

/*7.Trovate la traccia più lunga in ogni album.*/
SELECT 
    alb.Title AS titolo_album,
    tk.Name AS nome_traccia,
    MAX(tk.Milliseconds) AS max_durata
FROM
    album AS alb
        JOIN
    track AS tk ON alb.AlbumId = tk.AlbumId
GROUP BY alb.Title , tk.Name

/*8.Individuate la durata media delle tracce per ogni album.*/
SELECT 
    alb.Title AS titolo_album,
    AVG(tk.Milliseconds) AS media_durata
FROM
    album AS alb
        JOIN
    track AS tk ON alb.AlbumId = tk.AlbumId
GROUP BY alb.Title;


/*9.Individuate gli album che hanno più di 20 tracce e mostrate il nome dell’album e il numero di tracce in esso contenute.*/
SELECT 
    alb.Title AS titolo_album, COUNT(tk.TrackId) AS N_tracce
FROM
    album AS alb
        JOIN
    track AS tk ON alb.AlbumId = tk.AlbumId
GROUP BY alb.Title
HAVING COUNT(tk.TrackId) > 20;

