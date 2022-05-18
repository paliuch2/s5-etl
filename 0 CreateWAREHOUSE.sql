USE WAREHOUSE
GO

CREATE TABLE ARTYKUL
(
    ID_Artykul INTEGER IDENTITY(1,1) PRIMARY KEY,
	Tytul varchar(100),
	Typ_artykulu varchar(20) CHECK (Typ_artykulu IN (N'wiadomo��','felieton', 'wideo', 'podcast', 'infografika')),
	Czy_sponsorowany varchar(22) CHECK (Czy_sponsorowany IN ('Jest sponsorowany','Nie jest sponsorowany')),
	Kategoria_liczby_komentarzy varchar(20) CHECK (Kategoria_liczby_komentarzy IN ('brak','znikoma', N'ma�a', N'�rednia', N'du�a', 'ogromna')),
	Ocena_artykulu varchar(20) CHECK (Ocena_artykulu IN ('bardzo niska','niska', N'�rednia', 'wysoka', 'bardzo wysoka')),
	Dzial varchar(20) CHECK (Dzial IN ('Polityka', 'Kultura', 'Sport', 'Gospodarka', N'�wiat', 'Historia', 'Zdrowie', N'Spo�ecze�stwo', 'Media'))
)
GO


CREATE TABLE REKLAMA
(

	ID_Reklama INTEGER IDENTITY(1,1) PRIMARY KEY,
	Nazwa_produktu varchar(50),
	Typ_ekspozycji_reklamy varchar(25) CHECK (Typ_ekspozycji_reklamy IN ('wideo', 'grafika', 'plansza', 'sponsorowany')),
	Rodzaj_reklamy varchar(40) CHECK (Rodzaj_reklamy IN ('RTB', N'zwyk�a reklama', N'zwyk�a jako artyku� sponsorowany')),
)
GO

CREATE TABLE UMOWA
(

	ID_umowy INTEGER IDENTITY(1,1) PRIMARY KEY,
	Nazwa_firmy varchar(50),
	Dlugosc_obowiazywania_umowy varchar(50) CHECK (Dlugosc_obowiazywania_umowy IN (N'bardzo kr�tka', N'kr�tka', N'�rednia', N'd�uga', N'bardzo d�uga')),
)
GO

CREATE TABLE GODZINA
(
	ID_czas INTEGER IDENTITY(1,1) PRIMARY KEY,
	Godzina INTEGER CHECK (Godzina >=0 AND Godzina <= 23),
	Pora_dnia varchar(20) CHECK (Pora_dnia IN ('noc','poranek',N'przedpo�udnie',N'popo�udnie',N'wiecz�r'))
)
GO

CREATE TABLE DATA_ZDARZENIA
(

	ID_data INTEGER IDENTITY(1,1) PRIMARY KEY,
	Dokladna_data DATE,
	Rok INTEGER,
	Miesiac varchar(11) CHECK (Miesiac IN (N'stycze�','luty','marzec',N'kwiecie�','maj','czerwiec','lipiec',N'sierpie�',N'wrzesie�',N'pa�dziernik','listopad',N'grudzie�')),
	Dzien INTEGER CHECK (Dzien >=1 AND Dzien <= 31),
	Nr_miesiaca INTEGER CHECK (Nr_miesiaca >=1 AND Nr_miesiaca <= 12),
	Nr_dnia_tygodnia INTEGER CHECK (Nr_dnia_tygodnia >=1 AND Nr_dnia_tygodnia <= 7),
	Dzien_tygodnia varchar(12) CHECK (Dzien_tygodnia IN (N'poniedzia�ek','wtorek',N'�roda','czwartek',N'pi�tek','sobota','niedziela'))
)
GO

CREATE TABLE AUTOR
(
	ID_Autor INTEGER IDENTITY(1,1) PRIMARY KEY,
	Imie_Nazwisko varchar(50),
	Kategoria_wiekowa varchar(40) CHECK (Kategoria_wiekowa IN ('od 18 do 29 lat','od 30 do 39 lat',
															   'od 40 do 49 lat','od 50 do 59 lat',N'powy�ej 60 lat')),
	Dlugosc_stazu varchar(40) CHECK (Dlugosc_stazu IN (N'mniej ni� 3 miesi�ce','od 3 m-cy do roku',
													   'od roku do 3 lat',N'powy�ej 3 lat')),
	Czy_aktualny bit

)
GO

CREATE TABLE UMIESZCZENIE_REKLAMY_W_ARTYKULE
(
	ID_Reklama INTEGER FOREIGN KEY REFERENCES REKLAMA, 
	ID_Artykul  INTEGER FOREIGN KEY REFERENCES ARTYKUL,
	ID_Autor INTEGER FOREIGN KEY REFERENCES AUTOR,
	ID_Umowa INTEGER FOREIGN KEY REFERENCES UMOWA,
	ID_Data_zamieszczenia_artykulu INTEGER FOREIGN KEY REFERENCES DATA_ZDARZENIA,
	ID_Godzina_zamieszczenia_artykulu INTEGER FOREIGN KEY REFERENCES GODZINA,
	ID_Data_rozpoczecia_umowy INTEGER FOREIGN KEY REFERENCES DATA_ZDARZENIA,
	ID_Data_zakonczenia_umowy INTEGER FOREIGN KEY REFERENCES DATA_ZDARZENIA,

	Liczba_klikniec_w_reklame INTEGER,
	Liczba_wyswietlen_artykulu INTEGER,
	Przychod_za_klikniecie FLOAT(4),
	Cena_reklamy MONEY,
	

)
GO
