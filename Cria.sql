-- Gerado por Oracle SQL Developer Data Modeler 19.4.0.350.1424
--   em:        2020-09-20 10:50:55 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



CREATE TABLE t_sak_bairro (
    cd_bairro  NUMBER(4) NOT NULL,
    cd_cidade  NUMBER(3) NOT NULL,
    nm_bairro  VARCHAR2(100) NOT NULL
);

ALTER TABLE t_sak_bairro ADD CONSTRAINT pk_sak_bairro PRIMARY KEY ( cd_bairro );

CREATE TABLE t_sak_cidade (
    cd_cidade  NUMBER(3) NOT NULL,
    cd_estado  NUMBER(2) NOT NULL,
    nm_cidade  VARCHAR2(100) NOT NULL
);

ALTER TABLE t_sak_cidade ADD CONSTRAINT pk_sak_cidade PRIMARY KEY ( cd_cidade );

CREATE TABLE t_sak_dependente (
    cd_func        NUMBER(5) NOT NULL,
    id_dependente  NUMBER(3) NOT NULL,
    nm_dependente  VARCHAR2(50) NOT NULL,
    dt_nascimento  DATE NOT NULL,
    st_dependente  VARCHAR2(10) NOT NULL
);

ALTER TABLE t_sak_dependente
    ADD CONSTRAINT ck_sak_dependente_status CHECK ( st_dependente IN (
        'ATIVO',
        'INATIVO'
    ) );

ALTER TABLE t_sak_dependente ADD CONSTRAINT pk_sak_dependente PRIMARY KEY ( id_dependente,
                                                                            cd_func );

CREATE TABLE t_sak_depto (
    cd_depto  NUMBER(4) NOT NULL,
    nm_depto  VARCHAR2(60) NOT NULL,
    sg_depto  CHAR(3) NOT NULL
);

ALTER TABLE t_sak_depto ADD CONSTRAINT pk_sak_depto PRIMARY KEY ( cd_depto );

ALTER TABLE t_sak_depto ADD CONSTRAINT un_sak_depto_nome UNIQUE ( nm_depto );

CREATE TABLE t_sak_endereco (
    cd_end_correio  NUMBER NOT NULL,
    cd_bairro       NUMBER(4) NOT NULL,
    nr_cep          NUMBER(8) NOT NULL,
    ds_logradouro   VARCHAR2(150) NOT NULL
);

ALTER TABLE t_sak_endereco ADD CONSTRAINT pk_sak_endereco_correio PRIMARY KEY ( cd_end_correio );

CREATE TABLE t_sak_estado (
    cd_estado  NUMBER(2) NOT NULL,
    nm_estado  VARCHAR2(45) NOT NULL,
    sg_estado  CHAR(2) NOT NULL
);

ALTER TABLE t_sak_estado ADD CONSTRAINT pk_sak_estado PRIMARY KEY ( cd_estado );

CREATE TABLE t_sak_execucao_proj (
    cd_projeto          NUMBER(10) NOT NULL,
    cd_implantacao      NUMBER(3) NOT NULL,
    cd_func             NUMBER(5) NOT NULL,
    ds_papel_func_proj  VARCHAR2(100),
    dt_entrada          DATE NOT NULL,
    dt_saida            DATE
);

ALTER TABLE t_sak_execucao_proj ADD CONSTRAINT pk_sak_implantacao PRIMARY KEY ( cd_implantacao,
                                                                                cd_projeto );

CREATE TABLE t_sak_funcionario (
    cd_func          NUMBER(5) NOT NULL,
    cd_depto         NUMBER(4) NOT NULL,
    nm_funcionario   VARCHAR2(60) NOT NULL,
    dt_nascimento    DATE NOT NULL,
    ds_estado_civil  VARCHAR2(20),
    vl_salario       NUMBER(10, 2),
    dt_admissao      DATE NOT NULL
);

ALTER TABLE t_sak_funcionario ADD CONSTRAINT pk_sak_funcionario PRIMARY KEY ( cd_func );

CREATE TABLE t_sak_funcionario_endereco (
    cd_func           NUMBER(5) NOT NULL,
    cd_end_func       NUMBER(8) NOT NULL,
    cd_end_correio    NUMBER NOT NULL,
    cd_tipo_endereco  NUMBER(4) NOT NULL,
    ds_complemento    VARCHAR2(100) NULL,
    nr_logradouro     NUMBER(5) NOT NULL
);

ALTER TABLE t_sak_funcionario_endereco ADD CONSTRAINT pk_sak_funcionario_endereco PRIMARY KEY ( cd_end_func,
                                                                                                cd_func );

CREATE TABLE t_sak_projeto (
    cd_projeto         NUMBER(10) NOT NULL,
    nm_projeto         VARCHAR2(100) NOT NULL,
    vl_budget_projeto  NUMBER(10, 2) NOT NULL,
    dt_inicio          DATE NOT NULL,
    dt_termino         DATE
);

ALTER TABLE t_sak_projeto ADD CONSTRAINT pk_sak_projeto PRIMARY KEY ( cd_projeto );

ALTER TABLE t_sak_projeto ADD CONSTRAINT un_sak_projeto_nome UNIQUE ( nm_projeto );

CREATE TABLE t_sak_telefone (
    cd_func      NUMBER(5) NOT NULL,
    cd_telefone  NUMBER(3) NOT NULL,
    nr_ddd       NUMBER(3) NOT NULL,
    nr_telefone  NUMBER(8) NOT NULL
);

ALTER TABLE t_sak_telefone ADD CONSTRAINT pk_sak_telefone PRIMARY KEY ( cd_telefone,
                                                                        cd_func );

CREATE TABLE t_sak_tipo_endereco (
    cd_tipo_endereco  NUMBER(4) NOT NULL,
    nm_tipo_endereco  VARCHAR2(20) NOT NULL
);

ALTER TABLE t_sak_tipo_endereco ADD CONSTRAINT pk_sak_tipo_endereco PRIMARY KEY ( cd_tipo_endereco );

ALTER TABLE t_sak_endereco
    ADD CONSTRAINT fk_sak_bairro_endereco FOREIGN KEY ( cd_bairro )
        REFERENCES t_sak_bairro ( cd_bairro );

ALTER TABLE t_sak_bairro
    ADD CONSTRAINT fk_sak_cidade_bairro FOREIGN KEY ( cd_cidade )
        REFERENCES t_sak_cidade ( cd_cidade );

ALTER TABLE t_sak_funcionario
    ADD CONSTRAINT fk_sak_depto_func FOREIGN KEY ( cd_depto )
        REFERENCES t_sak_depto ( cd_depto );

ALTER TABLE t_sak_funcionario_endereco
    ADD CONSTRAINT fk_sak_end_correio_func FOREIGN KEY ( cd_end_correio )
        REFERENCES t_sak_endereco ( cd_end_correio );

ALTER TABLE t_sak_cidade
    ADD CONSTRAINT fk_sak_estado_cidade FOREIGN KEY ( cd_estado )
        REFERENCES t_sak_estado ( cd_estado );

ALTER TABLE t_sak_dependente
    ADD CONSTRAINT fk_sak_func_dependente FOREIGN KEY ( cd_func )
        REFERENCES t_sak_funcionario ( cd_func );

ALTER TABLE t_sak_funcionario_endereco
    ADD CONSTRAINT fk_sak_func_endereco FOREIGN KEY ( cd_func )
        REFERENCES t_sak_funcionario ( cd_func );

ALTER TABLE t_sak_execucao_proj
    ADD CONSTRAINT fk_sak_func_exec_proj FOREIGN KEY ( cd_func )
        REFERENCES t_sak_funcionario ( cd_func );

ALTER TABLE t_sak_telefone
    ADD CONSTRAINT fk_sak_func_telefone FOREIGN KEY ( cd_func )
        REFERENCES t_sak_funcionario ( cd_func );

ALTER TABLE t_sak_execucao_proj
    ADD CONSTRAINT fk_sak_proj_exec_proj FOREIGN KEY ( cd_projeto )
        REFERENCES t_sak_projeto ( cd_projeto );

ALTER TABLE t_sak_funcionario_endereco
    ADD CONSTRAINT fk_sak_tipo_endereco FOREIGN KEY ( cd_tipo_endereco )
        REFERENCES t_sak_tipo_endereco ( cd_tipo_endereco );


		-- Ajustes iniciais na tabela de telefone'
ALTER TABLE T_SAK_TELEFONE ADD TP_TELEFONE NUMBER(1);
ALTER TABLE T_SAK_TELEFONE MODIFY NR_TELEFONE NUMBER(9);

CREATE TABLE T_PESSOA
(
CD_PESSOA NUMBER,
NM_PESSOA VARCHAR2(60),
DS_PAPEL     VARCHAR2(40),
DT_INICIO DATE,
DT_TERMINO DATE,
CD_PESSOA_GESTOR NUMBER,
CONSTRAINT PK_PESSOA PRIMARY KEY (CD_PESSOA),
CONSTRAINT FK_PESSOA_GESTOR FOREIGN KEY (CD_PESSOA_GESTOR) REFERENCES T_PESSOA(CD_PESSOA)
);


-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            12
-- CREATE INDEX                             0
-- ALTER TABLE                             26
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0


