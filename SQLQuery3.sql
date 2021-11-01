
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

