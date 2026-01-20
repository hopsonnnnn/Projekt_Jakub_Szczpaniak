USE FitBase;
GO


CREATE OR ALTER TRIGGER trg_ArchiwizacjaKlienta
ON Klienci
AFTER DELETE
AS
BEGIN
    INSERT INTO Klienci_Archiwum (KlientID, Imie, Nazwisko, DataUsuniecia)
    SELECT KlientID, Imie, Nazwisko, GETDATE() FROM DELETED;
END;
GO


CREATE OR ALTER TRIGGER trg_WalidacjaCenyOferty
ON Oferta
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM INSERTED WHERE Cena < 0)
    BEGIN
        RAISERROR ('Błąd: Cena karnetu nie może być ujemna!', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO


CREATE OR ALTER TRIGGER trg_DezaktywacjaStarychKarnetow
ON Karnety
AFTER INSERT
AS
BEGIN
    
    UPDATE k
    SET k.CzyAktywny = 0
    FROM Karnety k
    INNER JOIN INSERTED i ON k.KlientID = i.KlientID
    WHERE k.KarnetID <> i.KarnetID;
END;
GO