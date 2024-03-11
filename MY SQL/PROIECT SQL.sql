CREATE DATABASE papetarie;
USE papetarie;
select * from papetarie;

CREATE TABLE Clienti (
  ClientID INT AUTO_INCREMENT PRIMARY KEY,
  Nume VARCHAR(100) NOT NULL,
  Adresa VARCHAR(255) NOT NULL,
  Telefon VARCHAR(15) NOT NULL
);

CREATE TABLE Produse (
  ProdusID INT AUTO_INCREMENT PRIMARY KEY,
  Denumire VARCHAR(100) NOT NULL,
  Pret FLOAT NOT NULL,
  Stoc INT NOT NULL
);

CREATE TABLE Comenzi (
  ComandaID INT AUTO_INCREMENT PRIMARY KEY,
  ClientID INT NOT NULL,
  DataComanda DATE NOT NULL,
  Total FLOAT NOT NULL,
  FOREIGN KEY (ClientID) REFERENCES Clienti(ClientID)
);

CREATE TABLE DetaliiComanda (
  ComandaID INT NOT NULL,
  ProdusID INT NOT NULL,
  Cantitate INT NOT NULL,
  FOREIGN KEY (ComandaID) REFERENCES Comenzi(ComandaID),
  FOREIGN KEY (ProdusID) REFERENCES Produse(ProdusID)
);
INSERT INTO Clienti(Nume, Adresa, Telefon) VALUES 
('Ana Pop', 'Strada Florilor 10', '0723123456'),
('Ion Ionescu', 'Bulevardul Unirii 5', '0745123456');

INSERT INTO Produse(Denumire, Pret, Stoc) VALUES 
('Creion', 1.5, 100),
('Caiet', 5.0, 50);

INSERT INTO Comenzi(ClientID, DataComanda, Total) VALUES 
(1, '2023-08-12', 6.5),
(2, '2023-08-11', 7.0);

INSERT INTO DetaliiComanda(ComandaID, ProdusID, Cantitate) VALUES 
(1, 1, 2),
(1, 2, 1),
(2, 1, 3);
-- Lista produselor vandabile
SELECT * FROM Produse;

-- Lista clienților
SELECT * FROM Clienti;

-- Lista comenzilor
SELECT * FROM Comenzi;

-- Lista comenzilor și clienților
SELECT c.ComandaID, cl.Nume, cl.Adresa, c.DataComanda FROM Comenzi c
JOIN Clienti cl ON c.ClientID = cl.ClientID;

-- Ultima comanda a clientului 'Ana Pop'
SELECT * FROM Comenzi WHERE ClientID = 1 ORDER BY DataComanda DESC LIMIT 1;

-- Statistici (un exemplu)
SELECT p.Denumire, SUM(dc.Cantitate) as TotalVandut FROM Produse p
JOIN DetaliiComanda dc ON p.ProdusID = dc.ProdusID
GROUP BY p.Denumire;

-- Folosind subinterogări
SELECT Denumire, 
       (SELECT SUM(Cantitate) FROM DetaliiComanda WHERE ProdusID = p.ProdusID) as TotalVandut 
FROM Produse p;
