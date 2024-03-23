USE Mais_Transporte

CREATE OR ALTER PROCEDURE SP_INSERIR_VIAGENS
AS
BEGIN
    DECLARE @TITULOS TABLE (TITULO VARCHAR(50))
    DECLARE @LOCAIS_ORIGEM TABLE (LOCAL_ORIGEM VARCHAR(50))
    DECLARE @LOCAIS_DESTINO TABLE (LOCAL_DESTINO VARCHAR(50))
    DECLARE @DESCRICOES TABLE (DESCRICAO VARCHAR(100))
    DECLARE @COD_MOTORISTAS TABLE (COD_MOTORISTA INT)

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

    INSERT INTO @COD_MOTORISTAS VALUES
    (1),
    (2),
    (3),
    (4),
    (5),
    (6),
    (7)

    DECLARE @CONTADOR INT = 1
    DECLARE @VIAGENS_DISPONIVEIS INT = 0
    DECLARE @VIAGENS_CANCELADAS INT = 0
    DECLARE @VIAGENS_CONFIRMADAS INT = 0
    DECLARE @VIAGENS_CONCLUIDAS INT = 0

    WHILE @CONTADOR <= 100
    BEGIN
        DECLARE @TITULO VARCHAR(50)
        DECLARE @LOCAL_ORIGEM VARCHAR(50)
        DECLARE @LOCAL_DESTINO VARCHAR(50)
        DECLARE @DESCRICAO VARCHAR(100)
        DECLARE @COD_MOTORISTA INT
        DECLARE @DATA_PARTIDA DATETIME
        DECLARE @DATA_CHEGADA DATETIME
        DECLARE @DATA_DISPONIVEL DATE
        DECLARE @VALOR_PASSAGEM NUMERIC(10,2)
        DECLARE @TOTAL_VAGAS INT
        DECLARE @STATUS VARCHAR(15)

        SELECT TOP 1 @TITULO = TITULO FROM @TITULOS ORDER BY NEWID()
        SELECT TOP 1 @LOCAL_ORIGEM = LOCAL_ORIGEM FROM @LOCAIS_ORIGEM ORDER BY NEWID()
        SELECT TOP 1 @LOCAL_DESTINO = LOCAL_DESTINO FROM @LOCAIS_DESTINO ORDER BY NEWID()
        SELECT TOP 1 @DESCRICAO = DESCRICAO FROM @DESCRICOES ORDER BY NEWID()
        SELECT TOP 1 @COD_MOTORISTA = COD_MOTORISTA FROM @COD_MOTORISTAS ORDER BY NEWID()

        SET @DATA_PARTIDA = DATEADD(DAY, -RAND()*365, '2024-01-01') -- Data de partida aleat�ria nos �ltimos 365 dias de 2023
        SET @DATA_DISPONIVEL = DATEADD(DAY, -CAST(RAND()*7 AS INT), @DATA_PARTIDA) -- Data dispon�vel aleat�ria entre 1 e 7 dias antes da partida
        SET @DATA_CHEGADA = DATEADD(DAY, RAND()*10, @DATA_PARTIDA) -- Data de chegada aleat�ria de at� 10 dias ap�s a partida
        SET @VALOR_PASSAGEM = RAND() * 40 + 10 -- Valor da passagem aleat�rio entre 10 e 50
        SET @TOTAL_VAGAS = CAST(RAND() * 45 + 6 AS INT) -- Total de vagas aleat�rio entre 6 e 50 (m�nimo de 6 vagas)

        -- Definindo o status com base no n�mero de viagens j� inseridas
        IF @VIAGENS_DISPONIVEIS < 20
        BEGIN
            SET @STATUS = 'DISPONIVEL'
            SET @VIAGENS_DISPONIVEIS += 1
        END
        ELSE IF @VIAGENS_CANCELADAS < 20
        BEGIN
            SET @STATUS = 'CANCELADA'
            SET @VIAGENS_CANCELADAS += 1
        END
        ELSE IF @VIAGENS_CONFIRMADAS < 30
        BEGIN
            SET @STATUS = 'CONFIRMADA'
            SET @VIAGENS_CONFIRMADAS += 1
        END
        ELSE
        BEGIN
            SET @STATUS = 'CONCLUIDA'
            SET @VIAGENS_CONCLUIDAS += 1
        END

        INSERT INTO TB_VIAGEM (TITULO, LOCAL_ORIGEM, LOCAL_DESTINO, VALOR_PASSAGEM, TOTAL_VAGAS, DATA_PARTIDA, DATA_CHEGADA, 
                                DATA_DISPONIVEL, DESCRICAO, STATUS, COD_MOTORISTA)
        VALUES (@TITULO, @LOCAL_ORIGEM, @LOCAL_DESTINO, @VALOR_PASSAGEM, @TOTAL_VAGAS, @DATA_PARTIDA, @DATA_CHEGADA,
                @DATA_DISPONIVEL, @DESCRICAO, @STATUS, @COD_MOTORISTA)

        SET @CONTADOR = @CONTADOR + 1
    END
END

EXEC SP_INSERIR_VIAGENS

SELECT * FROM TB_VIAGEM
