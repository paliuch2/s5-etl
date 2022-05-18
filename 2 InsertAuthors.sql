use WAREHOUSE

if (OBJECT_ID('AUTOR_VIEW') IS NOT NULL)
DROP VIEW AUTOR_VIEW;
GO

CREATE VIEW AUTOR_VIEW
AS 
WITH params AS (
    SELECT loaddate = '2021-01-01 00:00:00') -- dodane w celu testowania

SELECT DISTINCT

	[Imie_nazwisko] = Cast([Imie] + ' ' + [Nazwisko] as nvarchar(50)),

	CASE
		WHEN DATEDIFF (YEAR, [Data_urodzenia], loaddate) BETWEEN 18 AND 29 THEN 'od 18 do 29 lat'
		WHEN DATEDIFF (YEAR, [Data_urodzenia], loaddate) BETWEEN 30 AND 39 THEN 'od 30 do 39 lat'
		WHEN DATEDIFF (YEAR, [Data_urodzenia], loaddate) BETWEEN 40 AND 49 THEN 'od 40 do 49 lat'
		WHEN DATEDIFF (YEAR, [Data_urodzenia], loaddate) BETWEEN 50 AND 59 THEN 'od 50 do 59 lat'
		WHEN DATEDIFF (YEAR, [Data_urodzenia], loaddate) >= 60 THEN N'powy¿ej 60 lat'
	END AS [Kategoria_wiekowa],

	CASE
		WHEN DATEDIFF (MONTH, [W_redakcji_od], loaddate) < 3 THEN N'mniej ni¿ 3 miesi¹ce'
		WHEN DATEDIFF (MONTH, [W_redakcji_od], loaddate) BETWEEN 3 AND 12 THEN 'od 3 m-cy do roku'
		WHEN DATEDIFF (MONTH, [W_redakcji_od], loaddate) BETWEEN 13 AND 36 THEN 'od roku do 3 lat'	
		WHEN DATEDIFF (MONTH, [W_redakcji_od], loaddate) > 36 THEN N'powy¿ej 3 lat'
	END AS [Dlugosc_stazu]

FROM PolInfo.dbo.AUTORZY A, params;
GO

MERGE INTO AUTOR AS TT
	USING AUTOR_VIEW AS ST
		ON TT.Imie_nazwisko = ST.Imie_nazwisko
			WHEN NOT MATCHED
				THEN
					INSERT VALUES (
					ST.Imie_Nazwisko,
					ST.Kategoria_wiekowa,
					ST.Dlugosc_stazu,
					1
					)
			WHEN MATCHED
				AND (ST.Kategoria_wiekowa <> TT.Kategoria_wiekowa
				OR	ST.Dlugosc_stazu <> TT.Dlugosc_stazu)
			THEN UPDATE
				SET TT.Czy_aktualny = 0
			WHEN NOT MATCHED BY SOURCE
			THEN UPDATE
				SET TT.Czy_aktualny = 0;

INSERT INTO AUTOR(
	Imie_Nazwisko,
	Kategoria_wiekowa,
	Dlugosc_stazu,
	Czy_aktualny
	)
	SELECT
		Imie_Nazwisko,
		Kategoria_wiekowa,
		Dlugosc_stazu,
		1
		FROM AUTOR_VIEW
		EXCEPT
		SELECT
			Imie_Nazwisko,
			Kategoria_wiekowa,
			Dlugosc_stazu,
			1
		FROM AUTOR;
