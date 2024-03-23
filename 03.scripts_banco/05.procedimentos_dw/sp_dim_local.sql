USE Mais_Transporte

CREATE OR ALTER PROCEDURE SP_DIM_LOCAL (@DATA_CARGA DATETIME)
AS
BEGIN
	SET NOCOUNT ON
	SET LANGUAGE BRAZILIAN 

	INSERT INTO DIM_LOCAL (COD_LOCAL, LOCAL) 
	SELECT COD_LOCAL, LOCAL
	FROM TB_AUX_LOCAL
	WHERE DATA_CARGA = @DATA_CARGA

	UPDATE DIM_LOCAL
	SET COD_LOCAL = L.COD_LOCAL,
		LOCAL = L.LOCAL
	FROM DIM_LOCAL DL INNER JOIN TB_AUX_LOCAL L
	ON DL.COD_LOCAL = L.COD_LOCAL 
END

EXEC SP_DIM_LOCAL '20230320'

SELECT * FROM DIM_LOCAL