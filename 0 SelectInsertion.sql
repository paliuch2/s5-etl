SELECT Rek.Nazwa_produktu, Art.Tytul, Aut.Imie_Nazwisko, Umo.Nazwa_firmy, Dzam.Dokladna_data, Gzam.Godzina, Droz.Dokladna_data, Dzak.Dokladna_data, Liczba_klikniec_w_reklame, Liczba_wyswietlen_artykulu, Przychod_za_klikniecie, Cena_reklamy
FROM UMIESZCZENIE_REKLAMY_W_ARTYKULE AS Umi
JOIN REKLAMA AS Rek ON Rek.ID_Reklama = Umi.ID_Reklama
JOIN ARTYKUL AS Art ON Art.ID_Artykul = Umi.ID_Artykul
JOIN AUTOR AS Aut ON Aut.ID_Autor = Umi.ID_Autor
JOIN UMOWA AS Umo ON Umo.ID_umowy = Umi.ID_Umowa
JOIN DATA_ZDARZENIA AS Dzam ON Dzam.ID_data = Umi.ID_Data_zamieszczenia_artykulu
JOIN GODZINA AS Gzam ON Gzam.ID_czas = Umi.ID_Godzina_zamieszczenia_artykulu
JOIN DATA_ZDARZENIA AS Droz ON Droz.ID_data = Umi.ID_Data_rozpoczecia_umowy
JOIN DATA_ZDARZENIA AS Dzak ON Dzak.ID_data = Umi.ID_Data_zakonczenia_umowy
