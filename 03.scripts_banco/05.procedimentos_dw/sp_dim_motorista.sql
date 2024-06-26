USE Mais_Transporte

CREATE OR ALTER PROCEDURE SP_DIM_MOTORISTA (@DATA_CARGA DATETIME)
AS
BEGIN
	SET NOCOUNT ON
	SET LANGUAGE BRAZILIAN 

	INSERT INTO DIM_MOTORISTA (COD_MOTORISTA, NOME, CPF, TELEFONE, CNH, COD_VEICULO, PLACA) 
	SELECT COD_MOTORISTA, NOME, CPF, TELEFONE, CNH, COD_VEICULO, PLACA 
	FROM TB_AUX_MOTORISTA
	WHERE DATA_CARGA = @DATA_CARGA

	UPDATE DIM_MOTORISTA
	SET COD_MOTORISTA = M.COD_MOTORISTA,
		NOME = M.NOME,
		CPF = M.CPF,
		TELEFONE = M.TELEFONE,
		CNH = M.CNH,
		COD_VEICULO = M.COD_VEICULO,
		PLACA = M.PLACA
	FROM DIM_MOTORISTA DM INNER JOIN TB_AUX_MOTORISTA M
	ON DM.COD_MOTORISTA = M.COD_MOTORISTA 
END

EXEC SP_DIM_MOTORISTA '20240320'

SELECT * FROM DIM_MOTORISTA