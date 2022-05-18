use WAREHOUSE

DECLARE @godzina INT = 0

WHILE @godzina < 24 BEGIN

	IF @godzina < 4
		INSERT INTO GODZINA ("Godzina", "Pora_dnia") VALUES (@godzina, 'noc');
	ELSE IF @godzina < 10
		INSERT INTO GODZINA ("Godzina", "Pora_dnia") VALUES (@godzina, 'poranek');
	ELSE IF @godzina < 13
		INSERT INTO GODZINA ("Godzina", "Pora_dnia") VALUES (@godzina, N'przedpo³udnie');
	ELSE IF @godzina < 18
		INSERT INTO GODZINA ("Godzina", "Pora_dnia") VALUES (@godzina, N'popo³udnie');
	ELSE IF @godzina < 22
		INSERT INTO GODZINA ("Godzina", "Pora_dnia") VALUES (@godzina, N'wieczór');
	ELSE
		INSERT INTO GODZINA ("Godzina", "Pora_dnia") VALUES (@godzina, 'noc');

SET @godzina += 1

END
