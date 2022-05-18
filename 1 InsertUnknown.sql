USE WAREHOUSE

SET IDENTITY_INSERT AUTOR ON;  
GO

INSERT INTO AUTOR (
	  ID_Autor,
	  Imie_Nazwisko,
	  Kategoria_wiekowa,
	  Dlugosc_stazu,
	  Czy_aktualny) 
VALUES(-1, N'Nieokreœlony', 'od 18 do 29 lat', N'mniej ni¿ 3 miesi¹ce', 1);
GO

SET IDENTITY_INSERT AUTOR OFF;  
GO

SET IDENTITY_INSERT ARTYKUL ON;  
GO

INSERT INTO ARTYKUL (
	  ID_Artykul,
	  Tytul,
	  Typ_artykulu,
	  Czy_sponsorowany,
	  Kategoria_liczby_komentarzy,
	  Ocena_artykulu,
	  Dzial) 
VALUES(-1, N'Nieokreœlony', N'wiadomoœæ', 'Nie jest sponsorowany', 'brak', 'bardzo niska', 'Polityka');
GO

SET IDENTITY_INSERT ARTYKUL OFF;  
GO
