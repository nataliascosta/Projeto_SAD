USE Mais_Transporte

CREATE OR ALTER PROCEDURE SP_OLTP_STATUS (@DATA_CARGA DATETIME)
AS
BEGIN
    SET NOCOUNT ON
    SET LANGUAGE BRAZILIAN

    DELETE FROM TB_AUX_STATUS
	WHERE DATA_CARGA = @DATA_CARGA

    INSERT INTO TB_AUX_STATUS
    VALUES(@DATA_CARGA, 'DISPONIVEL', 1),
		  (@DATA_CARGA, 'CONFIRMADA', 2),
		  (@DATA_CARGA, 'CONCLUIDA', 3),
		  (@DATA_CARGA, 'CANCELADA', 4)
END

EXEC SP_OLTP_STATUS '20240320'

SELECT * FROM TB_AUX_STATUS