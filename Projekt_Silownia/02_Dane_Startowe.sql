USE FitBase;
GO


INSERT INTO Oferta (NazwaKarnetu, Cena, DlugoscDni) VALUES 
('Student 30', 99.00, 30),
('Standard 30', 149.00, 30),
('Open Rok', 1200.00, 365);


INSERT INTO Klienci (Imie, Nazwisko, Telefon) VALUES 
('Jan', 'Kowalski', '500-100-100'),
('Anna', 'Nowak', '600-200-200'),
('Piotr', 'Zielinski', '700-300-300'),
('Marta', 'Wojcik', '800-400-400');


INSERT INTO Karnety (KlientID, OfertaID, DataZakupu, DataWaznosci, CzyAktywny) VALUES
(1, 2, GETDATE(), DATEADD(day, 30, GETDATE()), 1),
(2, 1, '2023-01-01', '2023-02-01', 0);


INSERT INTO Wejscia (KlientID, DataWejscia) VALUES 
(1, DATEADD(hour, -2, GETDATE())),
(1, DATEADD(day, -1, GETDATE()));
GO