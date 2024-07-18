CREATE SCHEMA es1w6;
USE es1w6;
-- creazione tabella STORE
CREATE TABLE STORE (
    CodiceStore INT PRIMARY KEY,
    IndirizzoFisico VARCHAR(100),
    NumeroTelefono VARCHAR(100)
);
-- creazione tabella IMPIEGATO
    CREATE TABLE IMPIEGATO ( 
    CodiceFiscale VARCHAR(16) PRIMARY KEY,
    Nome VARCHAR(100),
    TitoloStudio VARCHAR(100),
    Recapito VARCHAR(100)
);
SELECT*FROM IMPIEGATO;

-- creazione tabella SERVIZIO_IMPIEGATO
CREATE TABLE SERVIZIO_IMPIEGATO ( 
    CodiceFiscale VARCHAR(16),
    CodiceStore INT,
    DataInizio DATE,
    DataFine DATE,
    Carica VARCHAR(100),
    FOREIGN KEY (CodiceFiscale) REFERENCES IMPIEGATO (CodiceFiscale),
    FOREIGN KEY (CodiceStore) REFERENCES STORE (CodiceStore)
);
-- creazione tabella VIDEOGIOCO
CREATE TABLE VIDEOGIOCO ( 
    Titolo VARCHAR(16),
  Sviluppatore VARCHAR(16),
    AnnoDistribuzione INT,
    CostoAcquisto DECIMAL(4,2),
    Genere VARCHAR(100),
    Remake VARCHAR(100)
);
SELECT * FROM VIDEOGIOCO;
-- popolamento tabella STORE
insert into STORE (CodiceStore, IndirizzoFisico,NumeroTelefono) values
(1, "Via Roma 123, Milano", "+39 02 1234567"),
    (2,"Corso Italia 456, Roma","+39 06 7654321"),
    (3,"Piazza San Marco 789, Venezia","+39 041 9876543"),
    (4,"Viale degli Ulivi 234, Napoli","+39 081 3456789"),
    (5,"Via Torino 567, Torino","+39 011 8765432"),
    (6,"Corso Vittorio Emanuele 890, Firenze","+39 055 2345678"),
    (7,"Piazza del Duomo 123, Bologna","+39 051 8765432"),
    (8,"Via Garibaldi 456, Genova","+39 010 2345678"),
    (9,"Lungarno Mediceo 789, Pisa","+39 050 8765432"),
    (10,"Corso Cavour 101, Palermo","+39 091 2345678");
   SELECT * FROM STORE; 
   -- popolamento tabella IMPIEGATO
   insert into IMPIEGATO (CodiceFiscale,Nome,TitoloStudio,Recapito) values
   ('ABC12345XYZ67890','Mario Rossi','Laurea in Economia','mario.rossi@email.com'),
   ('DEF67890XYZ12345','Anna Verdi','Diploma di Ragioneria','anna.verdi@email.com'),
   ('GHI12345XYZ67890','Luigi Bianchi','Laurea in Informatica','luigi.bianchi@email.com'),
   ('JKL67890XYZ12345','Laura Neri','Laurea in Lingue','laura.neri@email.com'),
   ('MNO12345XYZ67890','Andrea Moretti','Diploma di Geometra','andrea.moretti@email.com'),
   ('PQR67890XYZ12345','Giulia Ferrara','Laurea in Psicologia','giulia.ferrara@email.com'),
   ('STU12345XYZ67890','Marco Esposito','Diploma di Elettronica','marco.esposito@email.com'),
   ('VWX67890XYZ12345','Sara Romano','Laurea in Giurisprudenza','sara.romano@email.com'),
   ('YZA12345XYZ67890','Roberto De Luca','Diploma di Informatica','roberto.deluca@email.com'),
   ('BCD67890XYZ12345','Elena Santoro','Lurea in Lettere','elena.santoro@email.com');
SELECT *FROM IMPIEGATO;
-- popolamento tabella SERVIZI_IMPIEGATO
insert into SERVIZIO_IMPIEGATO (CodiceFiscale,CodiceStore,DataInizio,DataFine,Carica) values
 ("ABC12345XYZ67890",1,"2023-01-01","2024-12-31","Cassiere"),
("DEF67890XYZ12345",2,"2023-02-01","2024-11-30","Commesso"),
("GHI12345XYZ67890",3,"2023-03-01","2024-10-31","Magazziniere"),
("JKL67890XYZ12345",4,"2023-04-01","2024-09-30","Addetto alle vendite"),
("MNO12345XYZ67890",5,"2023-05-01","2024-08-31","Addetto alle pulizie"),
("PQR67890XYZ12345",6,"2023-06-01","2024-07-31","Commesso"),
("STU12345XYZ67890",7,"2023-07-01","2024-06-30","Commesso"),
("VWX67890XYZ12345",8,"2023-08-01","2024-05-31","Cassiere"),
("YZA12345XYZ67890",9,"2023-09-01","2024-04-30","Cassiere"),
("BCD67890XYZ12345",10,"2023-10-01","2024-03-31","Cassiere");
SELECT * FROM SERVIZIO_IMPIEGATO;
-- popolamento tabella VIDEOGIOCHI
insert into VIDEOGIOCHI (Titolo,AnnoDistribuzione,Genere,Sviluppatore,CostoAcquisto,Remeke) values
('Fifa 2023', 2023, 'Calcio', 'EA Sports', 49.99, NULL),
('Assassin''s Creed: Valhalla', 2020, 'Action', 'Ubisoft', 59.99, NULL),
('Super Mario Odyssey', 2017, 'Platform', 'Nintendo', 39.99, NULL),
('The Last of Us Part II', 2020, 'Action', 'Naughty Dog', 69.99, NULL),
('Cyberpunk 2077', 2020, 'RPG', 'CD Projekt Red', 49.99, NULL),
('Animal Crossing: New Horizons', 2020, 'Simulation', 'Nintendo', 54.99, NULL),
('Call of Duty: Warzone', 2020, 'FPS', 'Infinity Ward', 0.00, NULL),
('The Legend of Zelda: Breath of the Wild', 2017, 'Action-Adventure', 'Nintendo', 59.99, NULL),
('Fortnite', 2020, 'Battle Royale', 'Epic Games', 0.00, NULL),
('Red Dead Redemption 2', 2017, 'Action-Adventure', 'Rockstar Games', 39.99, NULL);
 SELECT*FROM VIDEOGIOCHI;  


   
