USE FitBase;
GO



CREATE OR ALTER FUNCTION fn_LiczbaWejscKlienta (@KlientID INT)
RETURNS INT
AS
BEGIN
    DECLARE @Liczba INT;
    SELECT @Liczba = COUNT(*) FROM Wejscia WHERE KlientID = @KlientID;
    RETURN @Liczba;
END;
GO


CREATE OR ALTER FUNCTION fn_AktualniKlienci ()
RETURNS TABLE
AS
RETURN
(
    SELECT k.Imie, k.Nazwisko, ka.DataWaznosci, o.NazwaKarnetu
    FROM Klienci k
    JOIN Karnety ka ON k.KlientID = ka.KlientID
    JOIN Oferta o ON ka.OfertaID = o.OfertaID
    WHERE ka.DataWaznosci >= GETDATE() AND ka.CzyAktywny = 1
);
GO


CREATE OR ALTER FUNCTION fn_RaportSprzedazyZData (@DataOd DATE, @DataDo DATE)
RETURNS TABLE
AS
RETURN
(
    SELECT o.NazwaKarnetu, k.DataZakupu, o.Cena
    FROM Karnety k
    JOIN Oferta o ON k.OfertaID = o.OfertaID
    WHERE k.DataZakupu BETWEEN @DataOd AND @DataDo
);
GO




CREATE OR ALTER VIEW v_ListaTelefonow AS
SELECT Imie, Nazwisko, Telefon FROM Klienci;
GO


CREATE OR ALTER VIEW v_SzczegolyKarnetow AS
SELECT 
    k.Imie, 
    k.Nazwisko, 
    o.NazwaKarnetu, 
    ka.DataWaznosci,
    CASE WHEN ka.DataWaznosci < GETDATE() THEN 'Wygasły' ELSE 'Aktywny' END AS Status
FROM Klienci k
JOIN Karnety ka ON k.KlientID = ka.KlientID
JOIN Oferta o ON ka.OfertaID = o.OfertaID;
GO


CREATE OR ALTER VIEW v_StatystykiPopularnosci AS
SELECT 
    o.NazwaKarnetu, 
    COUNT(ka.KarnetID) AS LiczbaSprzedanych, 
    SUM(o.Cena) AS LacznyPrzychod
FROM Oferta o
LEFT JOIN Karnety ka ON o.OfertaID = ka.OfertaID
GROUP BY o.NazwaKarnetu;
GO