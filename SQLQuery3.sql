
CREATE TRIGGER Ins_Ocena ON Ocena
AFTER INSERT
AS 
BEGIN
	INSERT INTO Ocena_Audit
	(Akcija,Datum_Akcije,NewUcenik,NewPredmet,NewNastavnik,
	NewOcena,NewDatum) 
	(SELECT 'Dodavanje', GETDATE(),
	Ucenik, Predmet, Nastavnik, Ocena, Datum FROM inserted )
END
insert into ocena values('Aleksa', 'Baze', 'Pusic', 5, '2021-10-12')

CREATE TRIGGER Del_Ocena ON Ocena
AFTER DELETE
AS 
BEGIN
	INSERT INTO Ocena_Audit
	(Akcija,Datum_Akcije,OldUcenik,OldPredmet,OldNastavnik,
	OldOcena,OldDatum) 
	(SELECT 'Brisanje', GETDATE(),
	Ucenik, Predmet, Nastavnik, Ocena, Datum FROM deleted )
END

DELETE FROM Ocena WHERE ID=6

CREATE TRIGGER Upd_Ocena ON Ocena
AFTER UPDATE
AS
BEGIN
INSERT INTO Ocena_Audit
	SELECT 'Izmena', GETDATE(), Del.ucenik, Ins.ucenik,
	Del.predmet, Ins.predmet, Del.nastavnik, Ins.nastavnik, 
	Del.ocena, Ins.ocena, Del.datum, Ins.datum 
	FROM inserted AS Ins JOIN deleted AS Del ON Ins.ID = Del.ID
END

UPDATE Ocena 
SET Ucenik='Pavle Georgijev', Ocena=6 WHERE ID=7