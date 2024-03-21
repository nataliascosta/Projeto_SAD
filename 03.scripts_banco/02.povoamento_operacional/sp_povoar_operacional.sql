USE Mais_Transporte

CREATE OR ALTER PROCEDURE SP_INSERIR_VIAGENS
AS
BEGIN
    DECLARE @TITULOS TABLE (TITULO VARCHAR(50))
    DECLARE @LOCAIS_ORIGEM TABLE (LOCAL_ORIGEM VARCHAR(50))
    DECLARE @LOCAIS_DESTINO TABLE (LOCAL_DESTINO VARCHAR(50))
    DECLARE @DESCRICOES TABLE (DESCRICAO VARCHAR(100))
    DECLARE @ID_MOTORISTA TABLE (ID_MOTORISTA INT)

    -- Preenchendo as vari�veis com dados fict�cios
    INSERT INTO @TITULOS VALUES
    ('Festa de Santo Ant�nio'),
    ('Passeio tur�stico para a praia'),
    ('Excurs�o para a Serra'),
    ('Visita a monumentos hist�ricos'),
    ('Tour gastron�mico'),
    ('Festa Carnavalesca'),
    ('Passeio de barco'),
    ('Passeio ao museu'),
    ('Passeio � piscina')

    INSERT INTO @LOCAIS_ORIGEM VALUES
    ('Itabaiana'),
    ('Aracaju'),
    ('Areia Branca'),
    ('Est�ncia'),
    ('S�o Crist�v�o'),
    ('Lagarto'),
    ('Ribeir�polis'),
    ('Laranjeiras'),
    ('Canind� de S�o Francisco'),
    ('Barra dos Coqueiros'),
    ('Moita Bonita'),
    ('Sim�o Dias'),
    ('Nossa Senhora do Socorro'),
    ('Porto da Folha'),
    ('Frei Paulo')

    INSERT INTO @LOCAIS_DESTINO VALUES
    ('Itabaiana'),
    ('Aracaju'),
    ('Areia Branca'),
    ('Est�ncia'),
    ('S�o Crist�v�o'),
    ('Lagarto'),
    ('Ribeir�polis'),
    ('Laranjeiras'),
    ('Canind� de S�o Francisco'),
    ('Barra dos Coqueiros'),
    ('Moita Bonita'),
    ('Sim�o Dias'),
    ('Nossa Senhora do Socorro'),
    ('Porto da Folha'),
    ('Frei Paulo')

    INSERT INTO @DESCRICOES VALUES
    ('Viagem de neg�cios'),
    ('Venha viajar com conforto e seguran�a'),
    ('Aventura ao ar livre, n�o perca!'),
    ('N�o h� reembolsos para atrasos.'),
    ('Venha viver essa experi�ncia �nica, com o Mais Transporte'),
    ('A maior aventura que voc� vai viver hoje, n�o perca!')

    INSERT INTO @ID_MOTORISTA VALUES
    (1),
    (2),
    (3),
    (4),
    (5),
    (6),
    (7),
    (8)

    DECLARE @CONTADOR INT = 1

    WHILE @CONTADOR <= 100
    BEGIN
        DECLARE @TITULO VARCHAR(50)
        DECLARE @LOCAL_ORIGEM VARCHAR(50)
        DECLARE @LOCAL_DESTINO VARCHAR(50)
        DECLARE @DESCRICAO VARCHAR(100)
        DECLARE @ID_MOTORISTAS INT
        DECLARE @DATA_PARTIDA DATETIME
        DECLARE @DATA_CHEGADA DATETIME
        DECLARE @VALOR_PASSAGEM NUMERIC(10,2)
        DECLARE @TOTAL_VAGAS INT

        SELECT TOP 1 @TITULO = TITULO FROM @TITULOS ORDER BY NEWID()
        SELECT TOP 1 @LOCAL_ORIGEM = LOCAL_ORIGEM FROM @LOCAIS_ORIGEM ORDER BY NEWID()
        SELECT TOP 1 @LOCAL_DESTINO = LOCAL_DESTINO FROM @LOCAIS_DESTINO ORDER BY NEWID()
        SELECT TOP 1 @DESCRICAO = DESCRICAO FROM @DESCRICOES ORDER BY NEWID()
        SELECT TOP 1 @ID_MOTORISTAS = ID_MOTORISTA FROM @ID_MOTORISTA ORDER BY NEWID()

        SET @DATA_PARTIDA = DATEADD(DAY, -RAND()*365, GETDATE()) -- Data de partida aleat�ria nos �ltimos 365 dias
        SET @DATA_CHEGADA = DATEADD(DAY, RAND()*10, @DATA_PARTIDA) -- Data de chegada aleat�ria de at� 10 dias ap�s a partida
        SET @VALOR_PASSAGEM = RAND() * 100 -- Valor da passagem aleat�rio entre 0 e 100
        SET @TOTAL_VAGAS = CAST(RAND() * 50 AS INT) -- Total de vagas aleat�rio entre 0 e 50

        INSERT INTO TB_VIAGEM (TITULO, LOCAL_ORIGEM, LOCAL_DESTINO, VALOR_PASSAGEM, TOTAL_VAGAS, DATA_PARTIDA, DATA_CHEGADA, DESCRICAO, ID_MOTORISTA)
        VALUES (@TITULO, @LOCAL_ORIGEM, @LOCAL_DESTINO, @VALOR_PASSAGEM, @TOTAL_VAGAS, @DATA_PARTIDA, @DATA_CHEGADA, @DESCRICAO, @ID_MOTORISTAS)

        SET @CONTADOR = @CONTADOR + 1
    END
END

EXEC SP_INSERIR_VIAGENS

SELECT * FROM TB_VIAGEM
