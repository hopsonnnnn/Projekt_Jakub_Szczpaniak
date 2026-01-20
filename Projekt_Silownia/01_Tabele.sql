
IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'FitBase')
BEGIN
    CREATE DATABASE FitBase;
END
GO

USE FitBase;
GO


CREATE TABLE Klienci (
    KlientID INT IDENTITY(1,1) PRIMARY KEY,
    Imie VARCHAR(50) NOT NULL,
    Nazwisko VARCHAR(50) NOT NULL,
    Telefon VARCHAR(15),
    DataRejestracji DATE DEFAULT GETDATE()
);


CREATE TABLE Oferta (
    OfertaID INT IDENTITY(1,1) PRIMARY KEY,
    NazwaKarnetu VARCHAR(50) NOT NULL,
    Cena DECIMAL(10,2) NOT NULL,
    DlugoscDni INT NOT NULL 
);


CREATE TABLE Karnety (
    KarnetID INT IDENTITY(1,1) PRIMARY KEY,
    KlientID INT FOREIGN KEY REFERENCES Klienci(KlientID),
    OfertaID INT FOREIGN KEY REFERENCES Oferta(OfertaID),
    DataZakupu DATE DEFAULT GETDATE(),
    DataWaznosci DATE, 
    CzyAktywny BIT DEFAULT 1 
);


CREATE TABLE Wejscia (
    WejscieID INT IDENTITY(1,1) PRIMARY KEY,
    KlientID INT FOREIGN KEY REFERENCES Klienci(KlientID),
    DataWejscia DATETIME DEFAULT GETDATE()
);


CREATE TABLE Klienci_Archiwum (
    ArchiwumID INT IDENTITY(1,1) PRIMARY KEY,
    KlientID INT,
    Imie VARCHAR(50),
    Nazwisko VARCHAR(50),
    DataUsuniecia DATETIME DEFAULT GETDATE()
);
GO