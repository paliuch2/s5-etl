use WAREHOUSE

DECLARE @Start date = '1980-01-01'
DECLARE @End date = '2021-12-31'

DECLARE @CurrentlyProcessed date = @Start;

WHILE @CurrentlyProcessed <= @End
BEGIN

INSERT INTO DATA_ZDARZENIA(Dokladna_data, Rok, Miesiac, Dzien, Nr_miesiaca, Dzien_tygodnia, Nr_dnia_tygodnia) VALUES 
(	@CurrentlyProcessed, 
	Cast(Year(@CurrentlyProcessed) as int), 
	CASE
		WHEN DATEPART(MONTH, @CurrentlyProcessed) = 1 THEN N'Styczeñ'
		WHEN DATEPART(MONTH, @CurrentlyProcessed) = 2 THEN 'Luty'
		WHEN DATEPART(MONTH, @CurrentlyProcessed) = 3 THEN 'Marzec'
		WHEN DATEPART(MONTH, @CurrentlyProcessed) = 4 THEN N'Kwiecieñ'
		WHEN DATEPART(MONTH, @CurrentlyProcessed) = 5 THEN 'Maj'
		WHEN DATEPART(MONTH, @CurrentlyProcessed) = 6 THEN 'Czerwiec'
		WHEN DATEPART(MONTH, @CurrentlyProcessed) = 7 THEN 'Lipiec'
		WHEN DATEPART(MONTH, @CurrentlyProcessed) = 8 THEN N'Sierpieñ'
		WHEN DATEPART(MONTH, @CurrentlyProcessed) = 9 THEN N'Wrzesieñ'
		WHEN DATEPART(MONTH, @CurrentlyProcessed) = 10 THEN N'PaŸdziernik'
		WHEN DATEPART(MONTH, @CurrentlyProcessed) = 11 THEN 'Listopad'
		WHEN DATEPART(MONTH, @CurrentlyProcessed) = 12 THEN N'Grudzieñ'
	END,
	Cast(Day(@CurrentlyProcessed) as int), 
	Cast(Month(@CurrentlyProcessed) as int),
	CASE
		WHEN DATENAME(dw, @CurrentlyProcessed) = 'Monday' THEN N'Poniedzia³ek'
		WHEN DATENAME(dw, @CurrentlyProcessed) = 'Tuesday' THEN 'Wtorek'
		WHEN DATENAME(dw, @CurrentlyProcessed) = 'Wednesday' THEN N'Œroda'
		WHEN DATENAME(dw, @CurrentlyProcessed) = 'Thursday' THEN 'Czwartek'
		WHEN DATENAME(dw, @CurrentlyProcessed) = 'Friday' THEN N'Pi¹tek'
		WHEN DATENAME(dw, @CurrentlyProcessed) = 'Saturday' THEN 'Sobota'
		WHEN DATENAME(dw, @CurrentlyProcessed) = 'Sunday' THEN 'Niedziela'
	END,
	CASE
		WHEN DATENAME(dw, @CurrentlyProcessed) = 'Monday' THEN 1
		WHEN DATENAME(dw, @CurrentlyProcessed) = 'Tuesday' THEN 2
		WHEN DATENAME(dw, @CurrentlyProcessed) = 'Wednesday' THEN 3
		WHEN DATENAME(dw, @CurrentlyProcessed) = 'Thursday' THEN 4
		WHEN DATENAME(dw, @CurrentlyProcessed) = 'Friday' THEN 5
		WHEN DATENAME(dw, @CurrentlyProcessed) = 'Saturday' THEN 6
		WHEN DATENAME(dw, @CurrentlyProcessed) = 'Sunday' THEN 7
	END
	)

	SET @CurrentlyProcessed = DATEADD(d,1,@CurrentlyProcessed);

END
