
ALTER TRIGGER Ins_Ocena ON Ocena
AFTER INSERT
AS 
BEGIN
	INSERT INTO Ocena_Audit
	(ID_Ocena, Akcija,Datum_Akcije,NewUcenik,NewPredmet,NewNastavnik,
	NewOcena,NewDatum) 
	(SELECT ID, 'Dodavanje', GETDATE(),
	Ucenik, Predmet, Nastavnik, Ocena, Datum FROM inserted )
END
insert into ocena values('Neda', 'Baze', 'Pusic', 5, '2021-10-12')

ALTER TRIGGER Del_Ocena ON Ocena
AFTER DELETE
AS 
BEGIN
	INSERT INTO Ocena_Audit
	(ID_Ocena, Akcija,Datum_Akcije,OldUcenik,OldPredmet,OldNastavnik,
	OldOcena,OldDatum) 
	(SELECT ID, 'Brisanje', GETDATE(),
	Ucenik, Predmet, Nastavnik, Ocena, Datum FROM deleted )
END

DELETE FROM Ocena WHERE ID=6

ALTER TRIGGER Upd_Ocena ON Ocena
AFTER UPDATE
AS
BEGIN
IF UPDATE(ucenik) 
INSERT INTO Ocena_Audit
	SELECT Ins.ID, 'Izmena', GETDATE(), Del.ucenik, Ins.ucenik,
	Del.predmet, Ins.predmet, Del.nastavnik, Ins.nastavnik, 
	Del.ocena, Ins.ocena, Del.datum, Ins.datum 
	FROM inserted AS Ins JOIN deleted AS Del ON Ins.ID = Del.ID
END

UPDATE Ocena SET Ucenik='Pavle Georgijev', Ocena=6 WHERE ID=8

SELECT * FROM Ocena_Audit WHERE ID_Ocena = 8