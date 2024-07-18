-- ricorda la parte schema
-- creazione tabella prodotti
CREATE TABLE prodotti (
    IDProdotto INT,
    NomeProdotto VARCHAR(100),
    Prezzo DECIMAL(10 , 2 ),
    CONSTRAINT PK_IDProdotto PRIMARY KEY (IDProdotto)
    -- IDProdotto INT PRIMARY KEY
);
-- creazione tabella clienti
CREATE TABLE Clienti (
    IDCliente INT,
    Nome VARCHAR(50),
    Email VARCHAR(100),
    CONSTRAINT PK_IDCliente PRIMARY KEY (IDCliente)
);
-- creazione tabella ordini
CREATE TABLE ordini (
    IDOrdini INT,
    IDProdotto INT,
    IDCliente INT,
    Quantità INT,
    CONSTRAINT PK_IDOrdini PRIMARY KEY (IDOrdini
    ),
    CONSTRAINT FK_IDProdotti_ordini FOREIGN KEY (IDProdotto)
        REFERENCES prodotti (IDProdotto),
    CONSTRAINT FK_IDCliente_ordini FOREIGN KEY (IDCliente)
        REFERENCES clienti (IDCliente)
);
-- creazione tabella dettaglio_ordini
CREATE TABLE Dettaglio_Ordini (
    IDOrdine INT,
    IDProdotto INT,
    IDCliente INT,
    CONSTRAINT PK_IDOrdine_IDProdotto_IDCliente PRIMARY KEY (IDOrdine , IDProdotto , IDCliente)
);
-- popolamento tabelle
INSERT INTO prodotti (IDProdotto,NomeProdotto,Prezzo) VALUES
(1, 'Tablet', 300.00),
(2, 'Mouse', 20.00),
(3, 'Tastiera', 25.00),
(4, 'Monitor', 180.00),
(5, 'HHD', 90.00),
(6, 'SSD', 200.00),
(7, 'RAM', 100.00),
(8, 'Router', 80.00),
(9, 'Webcam', 45.00),
(10, 'GPU', 1250.00),
(11, 'Trackpad', 500.00),
(12, 'Techmagazine', 5.00),
(13, 'Martech', 50.00);

INSERT INTO Ordini (IDOrdini, IDProdotto, Quantità) VALUES
(1, 2, 10),
(2, 6, 2),
(3, 5, 3),
(4, 1, 1),
(5, 9, 1),
(6, 4, 2),
(7, 11, 6),
(8, 10, 2),
(9, 3, 3),
(10, 3, 1),
(11, 2, 1);

SELECT * FROM ordini;

INSERT INTO Clienti (IDCliente, Nome, Email) VALUES
(1, 'Antonio', NULL),
(2, 'Battista', 'battista@mailmail.it'),
(3, 'Maria', 'maria@posta.it'),
(4, 'Franca', 'franca@lettere.it'),
(5, 'Ettore', NULL),
(6, 'Arianna', 'arianna@posta.it'),
(7, 'Piero', 'piero@lavoro.it');

SELECT* FROM clienti; 



