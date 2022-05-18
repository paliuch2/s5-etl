use WAREHOUSE

if (OBJECT_ID('ARTYKUL_VIEW') IS NOT NULL)
DROP view ARTYKUL_VIEW;
GO

if (OBJECT_ID('SPONS') IS NOT NULL)
DROP view SPONS;
GO

CREATE VIEW SPONS
AS
SELECT DISTINCT

  A.ID_Artykulu as [id]

FROM PolInfo.dbo.ARTYKULY A LEFT JOIN PolInfo.dbo.REKLAMY R
ON A.ID_Artykulu = R.FK_Artykul
WHERE R.Typ_ekspozycji_reklamy = 'sponsorowany';
GO

CREATE VIEW ARTYKUL_VIEW
AS
SELECT DISTINCT
	
	A.Tytul_Artykulu as [Tytul],
	A.Typ_artykulu as [Typ_artykulu],

	CASE
	WHEN A.ID_Artykulu IN (SELECT * FROM SPONS) THEN 'Jest sponsorowany'
	WHEN A.ID_Artykulu NOT IN (SELECT * FROM SPONS) THEN 'Nie jest sponsorowany'
	END AS [Czy_sponsorowany],
		
	CASE
	WHEN A.Liczba_komentarzy = 0 THEN 'brak'
	WHEN A.Liczba_komentarzy BETWEEN 1 AND 4 THEN 'znikoma'
	WHEN A.Liczba_komentarzy BETWEEN 5 AND 19 THEN N'ma³a'
	WHEN A.Liczba_komentarzy BETWEEN 20 AND 99 THEN N'œrednia'
	WHEN A.Liczba_komentarzy BETWEEN 100 AND 499 THEN N'du¿a'
	WHEN A.Liczba_komentarzy >= 500 THEN 'ogromna'
	END AS [Kategoria_liczby_komentarzy],
	
	CASE
	WHEN A.Ocena_Artykulu < 1.5 THEN 'bardzo niska'
	WHEN A.Ocena_Artykulu BETWEEN 1.5 AND 2.5 THEN 'niska'
	WHEN A.Ocena_Artykulu BETWEEN 2.5 AND 3.5 THEN N'œrednia'
	WHEN A.Ocena_Artykulu BETWEEN 3.5 AND 4.5 THEN 'wysoka'
	WHEN A.Ocena_Artykulu > 4.5 THEN 'bardzo wysoka'
	END AS [Ocena_artykulu],

	A.FK_Dzial as [Dzial]

FROM PolInfo.dbo.ARTYKULY A;
GO

MERGE INTO ARTYKUL AS TT
	USING ARTYKUL_VIEW AS ST
		ON TT.Tytul = ST.Tytul
			WHEN NOT MATCHED
				THEN
					INSERT VALUES (ST.Tytul, ST.Typ_artykulu, ST.Czy_sponsorowany, 
									ST.Kategoria_liczby_komentarzy, ST.Ocena_artykulu,
									ST.Dzial);

DROP VIEW ARTYKUL_VIEW
