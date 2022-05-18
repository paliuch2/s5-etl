use WAREHOUSE

if (OBJECT_ID('REKLAMA_VIEW') IS NOT NULL)
DROP VIEW REKLAMA_VIEW;
GO

CREATE VIEW REKLAMA_VIEW
AS 

SELECT DISTINCT
	
	R.Nazwa_produktu AS [Nazwa],
	R.Typ_ekspozycji_reklamy AS [Typ_ekspozycji_reklamy],

	CASE
	WHEN Typ_ekspozycji_reklamy = 'sponsorowany' THEN N'zwyk³a jako artyku³ sponsorowany'
	ELSE 'zwyk³a reklama'

	END AS [Rodzaj_reklamy]
		
FROM PolInfo.dbo.REKLAMY R 

GO

MERGE INTO REKLAMA AS TT
	USING REKLAMA_VIEW AS ST
		ON TT.Nazwa_produktu = ST.Nazwa
		AND TT.Typ_ekspozycji_reklamy = ST.Typ_ekspozycji_reklamy
			WHEN NOT MATCHED
				THEN
					INSERT VALUES (
						ST.Nazwa,
						ST.Typ_ekspozycji_reklamy,
						ST.Rodzaj_reklamy
					);
GO

if (OBJECT_ID('REKLAMA_TMP') IS NOT NULL)
DROP TABLE REKLAMA_TMP;
GO

if (OBJECT_ID('REKLAMA_VIEW') IS NOT NULL)
DROP VIEW REKLAMA_VIEW;
GO

if (OBJECT_ID('REKLAMA_VIEW2') IS NOT NULL)
DROP VIEW REKLAMA_VIEW2;
GO

CREATE TABLE REKLAMA_TMP (
	ID_umowy INTEGER,
	Nazwa_firmy varchar(50),
	Nazwa_produktu varchar(50),
	Subdomena varchar(5),
	Przychod FLOAT(6),
	Typ_ekspozycji varchar(25),
	Pierwsza_ekspozycja DATE,
	Ostatnia_ekspozycja DATE,
	Liczba_wyswietlen INTEGER,
	Liczba_klikniec INTEGER
)

BULK INSERT REKLAMA_TMP FROM 'C:\Users\kamil\Downloads\hd6\dane\AdNow1.csv'  WITH (FIRSTROW=2, FIELDTERMINATOR=',', CODEPAGE='65001')
GO

CREATE VIEW REKLAMA_VIEW2
AS 

SELECT DISTINCT
	

	Nazwa_produktu AS [Nazwa],
	Typ_ekspozycji AS [Typ_ekspozycji_reklamy],

	Rodzaj_reklamy = 'RTB'
		

FROM REKLAMA_TMP

GO

MERGE INTO REKLAMA AS TT
	USING REKLAMA_VIEW2 AS ST
		ON TT.Nazwa_produktu = ST.Nazwa
		AND TT.Typ_ekspozycji_reklamy = ST.Typ_ekspozycji_reklamy
			WHEN NOT MATCHED
				THEN
					INSERT VALUES (
						ST.Nazwa,
						ST.Typ_ekspozycji_reklamy,
						ST.Rodzaj_reklamy
					);			
Go
