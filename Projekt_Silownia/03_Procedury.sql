USE FitBase;
GO


CREATE OR ALTER PROCEDURE sp_ZakupKarnetu
    @KlientID INT,
    @OfertaID INT
AS
BEGIN
    DECLARE @Dni INT;
    SELECT @Dni = DlugoscDni FROM Oferta WHERE OfertaID = @OfertaID;
    
    INSERT INTO Karnety (KlientID, OfertaID, DataZakupu, DataWaznosci, CzyAktywny)
    VALUES (@KlientID, @OfertaID, GETDATE(), DATEADD(day, @Dni, GETDATE()), 1);
    
    PRINT 'Sukces: Karnet został zakupiony.';
END;
GO


CREATE OR ALTER PROCEDURE sp_RejestracjaWejscia
    @KlientID INT
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM Karnety 
        WHERE KlientID = @KlientID 
        AND CzyAktywny = 1 
        AND DataWaznosci >= GETDATE()
    )
    BEGIN
        INSERT INTO Wejscia (KlientID, DataWejscia) VALUES (@KlientID, GETDATE());
        PRINT 'Wejście zarejestrowane. Zapraszamy!';
    END
    ELSE
    BEGIN
        PRINT 'ODMOWA: Brak aktywnego karnetu!';
    END
END;
GO


CREATE OR ALTER PROCEDURE sp_UsunKlientaZWarunkiem
    @KlientID INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Karnety WHERE KlientID = @KlientID AND CzyAktywny = 1 AND DataWaznosci >= GETDATE())
    BEGIN
        PRINT 'Błąd: Nie można usunąć klienta z aktywnym karnetem.';
    END
    ELSE
    BEGIN
        DELETE FROM Wejscia WHERE KlientID = @KlientID;
        DELETE FROM Karnety WHERE KlientID = @KlientID;
        DELETE FROM Klienci WHERE KlientID = @KlientID;
        PRINT 'Klient został usunięty z systemu.';
    END
END;
GO