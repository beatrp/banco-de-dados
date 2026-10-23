-- =====================================================================
-- QrStudy - Sistema de Retirada Escolar por QR Code
-- Script de criação do banco de dados (PostgreSQL)
-- =====================================================================
-- Para executar:
--   1) CREATE DATABASE qrstudy;
--   2) Conectar ao banco qrstudy e executar este script.
-- =====================================================================

-- ---------------------------------------------------------------------
-- ESCOLA (RF-01)
-- ---------------------------------------------------------------------
CREATE TABLE escola (
    id_escola   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome        VARCHAR(150) NOT NULL,
    cnpj        CHAR(14)     NOT NULL,
    endereco    VARCHAR(200) NOT NULL,
    telefone    VARCHAR(20)  NOT NULL,
    email       VARCHAR(120) NOT NULL,
    CONSTRAINT uq_escola_cnpj UNIQUE (cnpj)                  -- RNFR-01.1
);

-- ---------------------------------------------------------------------
-- USUARIO: administradores e funcionários da escola (RF-01, RF-04, RF-08)
-- ---------------------------------------------------------------------
CREATE TABLE usuario (
    id_usuario  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_escola   INT          NOT NULL,
    nome        VARCHAR(120) NOT NULL,
    email       VARCHAR(120) NOT NULL,
    senha_hash  VARCHAR(255) NOT NULL,                       -- RNFS-03 (senha criptografada)
    perfil      VARCHAR(15)  NOT NULL,
    ativo       BOOLEAN      NOT NULL DEFAULT TRUE,
    CONSTRAINT uq_usuario_email UNIQUE (email),
    CONSTRAINT ck_usuario_perfil CHECK (perfil IN ('ADMINISTRADOR', 'FUNCIONARIO')),
    CONSTRAINT fk_usuario_escola FOREIGN KEY (id_escola)
        REFERENCES escola (id_escola)
);

-- ---------------------------------------------------------------------
-- RESPONSAVEL (RF-02, RF-04)
-- documento e cnh armazenam o valor criptografado (RNFR-02.2).
-- Obs.: a unicidade de "documento" (RNFR-02.1) só funciona se a
-- criptografia for determinística; caso contrário, use uma coluna
-- auxiliar com o hash do documento para a restrição UNIQUE.
-- ---------------------------------------------------------------------
CREATE TABLE responsavel (
    id_responsavel        INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_escola             INT          NOT NULL,
    id_usuario_validador  INT,
    nome                  VARCHAR(120) NOT NULL,
    documento             VARCHAR(255) NOT NULL,
    telefone              VARCHAR(20)  NOT NULL,
    email                 VARCHAR(120) NOT NULL,
    senha_hash            VARCHAR(255) NOT NULL,
    cnh                   VARCHAR(255),
    status_cadastro       VARCHAR(10)  NOT NULL DEFAULT 'PENDENTE',
    data_validacao        TIMESTAMP,
    CONSTRAINT uq_responsavel_documento UNIQUE (documento),  -- RNFR-02.1
    CONSTRAINT uq_responsavel_email UNIQUE (email),
    CONSTRAINT ck_responsavel_status CHECK (status_cadastro IN ('PENDENTE', 'APROVADO', 'REJEITADO')),
    CONSTRAINT fk_responsavel_escola FOREIGN KEY (id_escola)
        REFERENCES escola (id_escola),
    CONSTRAINT fk_responsavel_validador FOREIGN KEY (id_usuario_validador)
        REFERENCES usuario (id_usuario)                      -- RNFR-04.2
);

-- ---------------------------------------------------------------------
-- VEICULO (RF-02)
-- ---------------------------------------------------------------------
CREATE TABLE veiculo (
    id_veiculo      INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_responsavel  INT         NOT NULL,
    placa           VARCHAR(8)  NOT NULL,
    modelo          VARCHAR(60),
    cor             VARCHAR(30),
    CONSTRAINT fk_veiculo_responsavel FOREIGN KEY (id_responsavel)
        REFERENCES responsavel (id_responsavel) ON DELETE CASCADE
);

-- ---------------------------------------------------------------------
-- DOCUMENTO: arquivos enviados para validação (RF-03)
-- ---------------------------------------------------------------------
CREATE TABLE documento (
    id_documento     INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_responsavel   INT          NOT NULL,
    tipo             VARCHAR(40)  NOT NULL,
    nome_arquivo     VARCHAR(150) NOT NULL,
    caminho_arquivo  VARCHAR(255) NOT NULL,
    formato          VARCHAR(5)   NOT NULL,
    tamanho_bytes    INT          NOT NULL,
    data_envio       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT ck_documento_formato CHECK (formato IN ('PDF', 'JPG', 'PNG')),   -- RNFR-03.1
    CONSTRAINT ck_documento_tamanho CHECK (tamanho_bytes <= 10485760),          -- RNFR-03.2 (10 MB)
    CONSTRAINT fk_documento_responsavel FOREIGN KEY (id_responsavel)
        REFERENCES responsavel (id_responsavel) ON DELETE CASCADE
);

-- ---------------------------------------------------------------------
-- ALUNO (RF-05)
-- ---------------------------------------------------------------------
CREATE TABLE aluno (
    id_aluno         INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_escola        INT          NOT NULL,
    nome             VARCHAR(120) NOT NULL,
    data_nascimento  DATE         NOT NULL,
    cpf              CHAR(11)     NOT NULL,
    matricula        VARCHAR(20)  NOT NULL,
    serie            VARCHAR(30)  NOT NULL,
    turma            VARCHAR(20)  NOT NULL,
    CONSTRAINT uq_aluno_cpf UNIQUE (cpf),                            -- RNFR-05.1
    CONSTRAINT uq_aluno_matricula UNIQUE (id_escola, matricula),     -- RNFR-05.1
    CONSTRAINT fk_aluno_escola FOREIGN KEY (id_escola)
        REFERENCES escola (id_escola)
);

-- ---------------------------------------------------------------------
-- ALUNO_RESPONSAVEL: vínculo e autorização de retirada (RF-06)
-- Relacionamento N:N entre aluno e responsável.
-- ---------------------------------------------------------------------
CREATE TABLE aluno_responsavel (
    id_aluno         INT         NOT NULL,
    id_responsavel   INT         NOT NULL,
    id_usuario       INT         NOT NULL,   -- administrador que criou o vínculo
    parentesco       VARCHAR(30),
    data_vinculo     TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_revogacao   TIMESTAMP,
    ativo            BOOLEAN     NOT NULL DEFAULT TRUE,
    CONSTRAINT pk_aluno_responsavel PRIMARY KEY (id_aluno, id_responsavel),
    CONSTRAINT ck_vinculo_revogacao CHECK (data_revogacao IS NULL OR data_revogacao >= data_vinculo),
    CONSTRAINT fk_vinculo_aluno FOREIGN KEY (id_aluno)
        REFERENCES aluno (id_aluno),
    CONSTRAINT fk_vinculo_responsavel FOREIGN KEY (id_responsavel)
        REFERENCES responsavel (id_responsavel),
    CONSTRAINT fk_vinculo_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuario (id_usuario)
);

-- ---------------------------------------------------------------------
-- QR_CODE (RF-07, RF-08)
-- A chave estrangeira composta garante que só existe QR Code para um
-- par aluno/responsável que possui vínculo cadastrado.
-- ---------------------------------------------------------------------
CREATE TABLE qr_code (
    id_qrcode        INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_aluno         INT         NOT NULL,
    id_responsavel   INT         NOT NULL,
    token            VARCHAR(64) NOT NULL,
    data_geracao     TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_expiracao   TIMESTAMP   NOT NULL,
    status           VARCHAR(10) NOT NULL DEFAULT 'ATIVO',
    CONSTRAINT uq_qrcode_token UNIQUE (token),                        -- RNFR-07.1
    CONSTRAINT ck_qrcode_status CHECK (status IN ('ATIVO', 'USADO', 'EXPIRADO', 'REVOGADO')),
    CONSTRAINT ck_qrcode_validade CHECK (data_expiracao > data_geracao),
    CONSTRAINT fk_qrcode_vinculo FOREIGN KEY (id_aluno, id_responsavel)
        REFERENCES aluno_responsavel (id_aluno, id_responsavel)
);

-- ---------------------------------------------------------------------
-- RETIRADA (RF-09)
-- id_qrcode único: cada QR Code gera no máximo uma retirada.
-- Aluno e responsável são obtidos a partir do QR Code.
-- ---------------------------------------------------------------------
CREATE TABLE retirada (
    id_retirada         INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_qrcode           INT       NOT NULL,
    id_usuario          INT       NOT NULL,   -- funcionário que validou a saída
    data_hora_retirada  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,   -- RNFR-09.1
    CONSTRAINT uq_retirada_qrcode UNIQUE (id_qrcode),                   -- RNFR-09.2
    CONSTRAINT fk_retirada_qrcode FOREIGN KEY (id_qrcode)
        REFERENCES qr_code (id_qrcode),
    CONSTRAINT fk_retirada_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuario (id_usuario)
);

-- ---------------------------------------------------------------------
-- LOG_AUDITORIA (RNFS-07)
-- ---------------------------------------------------------------------
CREATE TABLE log_auditoria (
    id_log        INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario    INT,
    acao          VARCHAR(30)  NOT NULL,
    entidade      VARCHAR(40)  NOT NULL,
    id_registro   INT,
    data_hora     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    detalhes      VARCHAR(255),
    CONSTRAINT fk_log_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuario (id_usuario)
);

-- ---------------------------------------------------------------------
-- ÍNDICES para as consultas mais frequentes
-- (RNFR-10.2 e RNFR-10.3: histórico por aluno, responsável ou data)
-- ---------------------------------------------------------------------
CREATE INDEX idx_usuario_escola       ON usuario (id_escola);
CREATE INDEX idx_responsavel_escola   ON responsavel (id_escola, status_cadastro);
CREATE INDEX idx_aluno_escola         ON aluno (id_escola);
CREATE INDEX idx_aluno_nome           ON aluno (nome);
CREATE INDEX idx_vinculo_responsavel  ON aluno_responsavel (id_responsavel);
CREATE INDEX idx_qrcode_vinculo       ON qr_code (id_aluno, id_responsavel);
CREATE INDEX idx_qrcode_status        ON qr_code (status);
CREATE INDEX idx_retirada_data        ON retirada (data_hora_retirada);
CREATE INDEX idx_retirada_usuario     ON retirada (id_usuario);
CREATE INDEX idx_log_data             ON log_auditoria (data_hora);
