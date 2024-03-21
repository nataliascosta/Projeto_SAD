USE Mais_Transporte

CREATE OR ALTER PROCEDURE SP_OLTP_LOCAL (@DATA_CARGA DATETIME)
AS
BEGIN
    SET NOCOUNT ON;
    SET LANGUAGE BRAZILIAN

    INSERT INTO TB_AUX_LOCAL
    VALUES(@DATA_CARGA, 'Itabaiana', 1),
		  (@DATA_CARGA, 'Aracaju', 2),
		  (@DATA_CARGA, 'Areia Branca', 3),
		  (@DATA_CARGA, 'Est�ncia', 4),
		  (@DATA_CARGA, 'S�o Crist�v�o', 5),
		  (@DATA_CARGA, 'Lagarto', 6),
		  (@DATA_CARGA, 'Ribeir�polis', 7),
		  (@DATA_CARGA, 'Laranjeiras', 8),
		  (@DATA_CARGA, 'Canind� de S�o Francisco', 9),
		  (@DATA_CARGA, 'Barra dos Coqueiros', 10),
		  (@DATA_CARGA, 'Moita Bonita', 11),
		  (@DATA_CARGA, 'Sim�o Dias', 12),
		  (@DATA_CARGA, 'Nossa Senhora do Socorro', 13),
		  (@DATA_CARGA, 'Porto da Folha', 14),
		  (@DATA_CARGA, 'Frei Paulo', 15)
END

EXEC SP_OLTP_LOCAL '20230320'

SELECT * FROM TB_AUX_LOCAL