USE Mais_Transporte

CREATE TABLE DIM_LOCAL (
  ID_LOCAL INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
  LOCAL VARCHAR(45) NULL,
  COD_LOCAL INT NULL
)

CREATE TABLE DIM_STATUS (
  ID_STATUS INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
  Status VARCHAR(15) NOT NULL CHECK(STATUS IN ('DISPONIVEL', 'CONFIRMADA', 'CONCLUIDA', 'CANCELADA')),
  COD_STATUS_VIAGEM INT NULL
)

CREATE TABLE DIM_MOTORISTA (
  ID_MOTORISTA INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
  COD_MOTORISTA INT NULL,
  NOME VARCHAR(45) NULL,
  CPF VARCHAR(11) NULL,
  TELEFONE VARCHAR(15) NULL,
  CNH VARCHAR(15) NOT NULL UNIQUE
)

CREATE TABLE DIM_VEICULO (
  ID_VEICULO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
  COD_VEICULO INT NULL,
  RENAVAM VARCHAR(15) NOT NULL,
  PLACA VARCHAR(10) NOT NULL,
  DATA_EMISSAO DATETIME NULL,
  EXPEDIDOR VARCHAR(5) NULL,
  ESTADO VARCHAR(2) NULL
)

CREATE TABLE DIM_TEMPO (
	ID_TEMPO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	NIVEL VARCHAR(8) NOT NULL CHECK (NIVEL IN ('DIA','MES','ANO')),
	DATA DATETIME NULL,
	DIA INT NULL,
	DIA_SEMANA VARCHAR(50) NULL,
	FIM_SEMANA VARCHAR(3) NULL CHECK (FIM_SEMANA IN ('SIM','NAO')),
	FERIADO VARCHAR(100) NULL,
	FL_FERIADO VARCHAR(3) NULL CHECK (FL_FERIADO IN ('SIM','NAO')),
	MES INT NULL,
	NOME_MES VARCHAR(100) NULL,
	TRIMESTRE INT NULL,
	NOME_TRIMESTRE VARCHAR(100) NULL,
	SEMESTRE INT NULL,
	NOME_SEMESTRE VARCHAR(100) NULL,
	ANO INT NOT NULL
)

CREATE INDEX IX_DIM_TEMPO_DATA ON DIM_TEMPO (DATA)


CREATE TABLE FATO_VIAGEM (
  ID_VIAGEM BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
  ID_LOCAL_DESTINO INT NOT NULL,
  ID_LOCAL_ORIGEM INT NOT NULL,
  ID_STATUS INT NOT NULL,
  ID_MOTORISTA INT NOT NULL,
  ID_VEICULO INT NOT NULL,
  ID_DATA_DISPONIVEL INT NULL,
  ID_DATA_CONFIRMACAO INT NULL,
  ID_DATA_CONCLUIDA INT NULL,
  ID_DATA_CANCELAMENTO INT NULL,
  QUANTIDADE INT NOT NULL DEFAULT (1),
  VALOR NUMERIC(10,2) NULL,
  CONSTRAINT FK_DIM_LOCAL_ORIGEM FOREIGN KEY (ID_LOCAL_ORIGEM) REFERENCES DIM_LOCAL (ID_LOCAL),
  CONSTRAINT FK_DIM_STATUS FOREIGN KEY (ID_STATUS) REFERENCES DIM_STATUS (ID_STATUS),
  CONSTRAINT FK_DIM_MOTORISTA FOREIGN KEY (ID_MOTORISTA) REFERENCES DIM_MOTORISTA (ID_MOTORISTA), 
  CONSTRAINT FK_DIM_VEICULO FOREIGN KEY (ID_VEICULO) REFERENCES DIM_VEICULO (ID_VEICULO),
  CONSTRAINT FK_DIM_LOCAL_DESTINO FOREIGN KEY (ID_LOCAL_DESTINO) REFERENCES DIM_LOCAL (ID_LOCAL),
  CONSTRAINT FK_DIM_TEMPO_DISPONIVEL FOREIGN KEY (ID_DATA_DISPONIVEL) REFERENCES DIM_TEMPO (ID_TEMPO),
  CONSTRAINT FK_DIM_TEMPO_CONFIRMACAO FOREIGN KEY (ID_DATA_CONFIRMACAO) REFERENCES DIM_TEMPO (ID_TEMPO),
  CONSTRAINT FK_DIM_TEMPO_CONCLUIDA FOREIGN KEY (ID_DATA_CONCLUIDA) REFERENCES DIM_TEMPO (ID_TEMPO),
  CONSTRAINT FK_DIM_TEMPO_CANCELAMENTO FOREIGN KEY (ID_DATA_CANCELAMENTO) REFERENCES DIM_TEMPO (ID_TEMPO),
)

CREATE INDEX IX_FATO_VIAGEM_LOCAL_DESTINO ON FATO_VIAGEM (ID_LOCAL_DESTINO)
CREATE INDEX IX_FATO_VIAGEM_STATUS ON FATO_VIAGEM (ID_STATUS)
CREATE INDEX IX_FATO_VIAGEM_MOTORISTA ON FATO_VIAGEM (ID_MOTORISTA)
CREATE INDEX IX_FATO_VIAGEM_LOCAL_ORIGEM ON FATO_VIAGEM (ID_LOCAL_ORIGEM)
CREATE INDEX IX_FATO_VIAGEM_TEMPO_DISPONIVEL ON FATO_VIAGEM (ID_DATA_DISPONIVEL)
CREATE INDEX IX_FATO_VIAGEM_TEMPO_CONFIRMADA ON FATO_VIAGEM (ID_DATA_CONFIRMACAO)
CREATE INDEX IX_FATO_VIAGEM_TEMPO_CONCLUIDA ON FATO_VIAGEM (ID_DATA_CONCLUIDA)
CREATE INDEX IX_FATO_VIAGEM_TEMPO_CANCELAMENTO ON FATO_VIAGEM (ID_DATA_CANCELAMENTO)