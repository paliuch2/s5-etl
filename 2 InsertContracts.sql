use WAREHOUSE

if (OBJECT_ID('UMOWA_VIEW') IS NOT NULL)
DROP VIEW UMOWA_VIEW;
GO

CREATE VIEW UMOWA_VIEW
AS 

SELECT DISTINCT
	
	F.Nazwa AS [Nazwa],

	CASE
		WHEN DATEDIFF (DAY, [Data_rozpoczecia], [Data_zakonczenia]) > 365 THEN N'bardzo d³uga'
		WHEN DATEDIFF (DAY, [Data_rozpoczecia], [Data_zakonczenia]) BETWEEN 181 AND 365 THEN N'd³uga'
		WHEN DATEDIFF (DAY, [Data_rozpoczecia], [Data_zakonczenia]) BETWEEN 91 AND 180 THEN N'œrednia'
		WHEN DATEDIFF (DAY, [Data_rozpoczecia], [Data_zakonczenia]) BETWEEN 30 AND 90 THEN N'krótka'
		WHEN DATEDIFF (DAY, [Data_rozpoczecia], [Data_zakonczenia]) BETWEEN 0 AND 29 THEN N'bardzo krótka'
	END AS [Dlugosc_obowiazywania_umowy]
		
FROM PolInfo.dbo.UMOWY_REKLAMOWE U JOIN PolInfo.dbo.FIRMY_REKLAMOWE F
ON U.FK_Firma = F.REGON
GO

MERGE INTO UMOWA AS TT
	USING UMOWA_VIEW AS ST
		ON TT.Nazwa_firmy = ST.Nazwa
		AND TT.Dlugosc_obowiazywania_umowy = ST.Dlugosc_obowiazywania_umowy
			WHEN NOT MATCHED
				THEN
					INSERT VALUES (
				--	ST.Nr_umowy,
					ST.Nazwa,
					ST.Dlugosc_obowiazywania_umowy
					);
