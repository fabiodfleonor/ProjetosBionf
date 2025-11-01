-- Projeto Grupo T1_G2 - Francisco Silva 202200631, João Silva 202200190, Gonçalo Fernandes 202200577, Lara Evangelista 202200655

USE T1_G2
GO

--CREATE SCHEMA PROJETO
--GO

CREATE TABLE PROJETO.Colaborador (
	ID_Colaborador int IDENTITY(1,1) PRIMARY KEY
	,Nome varchar(100) NOT NULL 
	,Telemóvel varchar(9)
	,Email varchar(100) NOT NULL 
	,NIF varchar(9) NOT NULL
	,Morada varchar(100) 
	,Departamento varchar(40) NOT NULL
)

CREATE TABLE PROJETO.Superior(
	ID_Superior int IDENTITY(1,1) PRIMARY KEY
	,Nome_Superior varchar(100) NOT NULL
	,Telemóvel varchar(9)
	,Email varchar(100) NOT NULL 
	,NIF varchar(9) NOT NULL
	,Morada varchar(100) 
	,Posição_Superior varchar(80) NOT NULL
)

CREATE TABLE PROJETO.Origem (
	ID_Origem int IDENTITY(1,1) PRIMARY KEY
	,Designação_Origem varchar(100) NOT NULL
)

CREATE TABLE PROJETO.Destino (
	ID_Destino int IDENTITY(1,1) PRIMARY KEY
	,Designação_Destino varchar(100) NOT NULL
)

CREATE TABLE PROJETO.Tipo_Financiamento(
	ID_Tipo_Financiamento int IDENTITY(1,1) PRIMARY KEY
	,Designação_Tipo_Financiamento varchar(25) NOT NULL
)

CREATE TABLE PROJETO.Tipo_Transporte(
	ID_Tipo_Transporte int IDENTITY(1,1) PRIMARY KEY
	,Designação_Transporte varchar(25) NOT NULL
)

CREATE TABLE PROJETO.Anexo(
	ID_Anexo int IDENTITY(1,1) PRIMARY KEY
	,ID_Tipo_Anexo int FOREIGN KEY REFERENCES PROJETO.Tipo_Anexo(ID_Tipo_Anexo) NOT NULL
	,ID_Pedido_Deslocação int FOREIGN KEY REFERENCES PROJETO.Pedido_Deslocação(ID_Pedido_Deslocação) NOT NULL
	,Descrição_Anexo varchar(300) 
)

CREATE TABLE PROJETO.Tipo_Anexo(
	ID_Tipo_Anexo int IDENTITY(1,1) PRIMARY KEY
	,Designação_Tipo_Anexo varchar(50) NOT NULL
)

CREATE TABLE PROJETO.Mês (
	ID_Mês int IDENTITY(1,1) PRIMARY KEY
	,Designação_Mês varchar(20) NOT NULL
)


CREATE TABLE PROJETO.Pedido_Deslocação(
	ID_Pedido_Deslocação int IDENTITY(1,1) PRIMARY KEY
	,Data_Preenchimento_Deslocação date NOT NULL
	,ID_Colaborador int FOREIGN KEY REFERENCES PROJETO.Colaborador(ID_Colaborador) NOT NULL
	,Serviço varchar(300) NOT NULL
	,ID_Origem int FOREIGN KEY REFERENCES PROJETO.Origem(ID_Origem) NOT NULL
	,ID_Destino int FOREIGN KEY REFERENCES PROJETO.Destino(ID_Destino) NOT NULL
	,Data_Início smalldatetime NOT NULL
	,Data_Fim smalldatetime NOT NULL
	,ID_Mês int FOREIGN KEY REFERENCES PROJETO.Mês(ID_Mês) NOT NULL
	,ID_Tipo_Financiamento int FOREIGN KEY REFERENCES PROJETO.Tipo_Financiamento(ID_Tipo_Financiamento) NOT NULL
	,Descrição_Apoio_Externo varchar (200)
	,ID_Tipo_Transporte int FOREIGN KEY REFERENCES PROJETO.Tipo_Transporte(ID_Tipo_Transporte) NOT NULL
	,Custo_Inscrição money 
	,Custo_Alojamento money 
	,Num_Refeições int
	,ID_Superior int FOREIGN KEY REFERENCES PROJETO.Superior(ID_Superior)
	,[Status] varchar(20) DEFAULT 'PENDENTE'
)

CREATE TABLE PROJETO.Pedido_Reembolso(
	ID_Pedido_Reembolso int CONSTRAINT ID_Pedido_Reembolso PRIMARY KEY (ID_Pedido_Reembolso, Nº_Pedido)
	,Nº_Pedido int UNIQUE NOT NULL
	,ID_Colaborador int FOREIGN KEY REFERENCES PROJETO.Colaborador(ID_Colaborador) NOT NULL
	,ID_Mês int FOREIGN KEY REFERENCES PROJETO.Mês(ID_Mês)
	,Data_Preenchimento_Reembolso date NOT NULL
	,Serviço varchar(300) NOT NULL
	,ID_Origem int FOREIGN KEY REFERENCES PROJETO.Origem(ID_Origem) NOT NULL
	,ID_Destino int FOREIGN KEY REFERENCES PROJETO.Destino(ID_Destino) NOT NULL
	,Data_Início smalldatetime NOT NULL
	,Data_Fim smalldatetime NOT NULL
	,ID_Tipo_Transporte int FOREIGN KEY REFERENCES PROJETO.Tipo_Transporte(ID_Tipo_Transporte) NOT NULL
	,Importância_Total int NOT NULL -- Soma do custo das anteriores
	,Observações varchar (300)
	
)


INSERT INTO PROJETO.Tipo_Transporte(Designação_Transporte)
VALUES ('Veículo de serviço'), ('Transporte público'), ('Veículo próprio'), ('A pé')

INSERT INTO PROJETO.Tipo_Financiamento(Designação_Tipo_Financiamento)
VALUES ('Com apoio da entidade'), ('Outro apoio externo'), ('Sem apoio')

INSERT INTO PROJETO.Mês(Designação_Mês)
VALUES('Janeiro'), ('Fevereiro'), ('Março'), ('Abril'), ('Maio'), ('Junho'), ('Julho'), ('Agosto'), ('Setembro'), ('Outubro'), ('Novembro'), ('Dezembro')

INSERT INTO PROJETO.Destino(Designação_Destino)
VALUES ('ESTBarreiro')

INSERT INTO PROJETO.Colaborador (Nome, Telemóvel, Email, NIF, Departamento)
VALUES ('Paulo Santos', '961234123', 'paulosantos12345@gmail.com', '241589209', 'Informárica')

INSERT INTO PROJETO.Superior
VALUES ('Francisco Piedade', '987654321', 'fpiedade123@gmail.com', '123456789', 'Rua dos Aleijados', 'Chefe de Departamento de Informática')

CREATE OR ALTER PROC PROJETO.SP_Submeter_Pedido_Deslocação -- Stored Procedure para submeter um pedido de deslocação 
	@Data_Preenchimento DATE,
	@ID_Colaborador INT,
	@Serviço VARCHAR(300),
	@Origem VARCHAR(100),
	@Destino VARCHAR(100),
	@Data_Inicio SMALLDATETIME,
	@Data_Fim SMALLDATETIME,
	@Tipo_Financiamento VARCHAR(25),
	@Descrição_Apoio_Externo VARCHAR(200),
	@Custo_Inscrição MONEY,
	@Custo_Alojamento MONEY,
	@Num_Refeições INT,
	@Tipo_Transporte VARCHAR(25)
AS
BEGIN
	BEGIN TRAN

	DECLARE @ID_Tipo_Financiamento INT
	DECLARE @ID_Origem INT
	DECLARE @ID_Destino INT
	DECLARE @ID_Tipo_Transporte int

	SELECT @ID_Tipo_Financiamento = ID_Tipo_Financiamento -- obter o ID_Financiamento a partir da sua designação
	FROM PROJETO.Tipo_Financiamento
	WHERE Designação_Tipo_Financiamento = @Tipo_Financiamento

	SELECT @ID_Origem = ID_Origem -- obter o ID_Origem a partir da sua designação
	FROM PROJETO.Origem
	WHERE Designação_Origem = @Origem

	SELECT @ID_Destino = ID_Destino -- obter o ID_Destino a partir da sua designação
	FROM PROJETO.Destino
	WHERE Designação_Destino = @Destino

	SELECT @ID_Tipo_Transporte = ID_Tipo_Transporte -- obter o ID_Tipo_Transporte a partir da sua designação
	FROM PROJETO.Tipo_Transporte
	WHERE Designação_Transporte = @Tipo_Transporte

	IF @Tipo_Financiamento <> 'Sem apoio' -- Condição para caso o tipo de financiamento seja sem apoio nao inserir na tabela os atributos Custo_Inscrição, 
	                                       --Custo_Alojamento, Num_Refeições caso o tipo de financiamento seja diferente inserir esses atributos
	BEGIN
		INSERT INTO PROJETO.Pedido_Deslocação (Data_Preenchimento_Deslocação, ID_Colaborador, Serviço, ID_Origem, ID_Destino, 
		Data_Início, Data_Fim, ID_Tipo_Financiamento, Descrição_Apoio_Externo, ID_Tipo_Transporte)
		VALUES (@Data_Preenchimento, @ID_Colaborador, @Serviço, @ID_Origem, @ID_Destino, @Data_Inicio, @Data_Fim, @ID_Tipo_Financiamento, @Descrição_Apoio_Externo, @ID_Tipo_Transporte)
	END
	ELSE 
	BEGIN
		INSERT INTO PROJETO.Pedido_Deslocação (Data_Preenchimento_Deslocação, ID_Colaborador, Serviço, ID_Origem, 
		ID_Destino, Data_Início, Data_Fim, ID_Tipo_Financiamento, ID_Tipo_Transporte, Custo_Inscrição, Custo_Alojamento, Num_Refeições)
		VALUES (@Data_Preenchimento, @ID_Colaborador, @Serviço, @ID_Origem, @ID_Destino, @Data_Inicio, @Data_Fim, @ID_Tipo_Financiamento, @ID_Tipo_Transporte, @Custo_Inscrição, @Custo_Alojamento, @Num_Refeições)
	END

	IF @Tipo_Financiamento = 'Sem apoio' AND (@Custo_Inscrição IS NOT NULL OR @Custo_Alojamento IS NOT NULL OR @Num_Refeições IS NOT NULL)
	BEGIN
		PRINT 'Apenas pode inserir despesas se o Financiamento for feito pela entidade ou externo'
	END

	COMMIT TRAN
	RETURN
END
GO

CREATE OR ALTER PROC PROJETO.SP_Aprovar_Pedido_Deslocação -- Stored Procedure para aprovar pedidos de deslocação
	@ID_Pedido_Deslocação int
	,@ID_Superior int
	,@Status varchar(20)

AS
BEGIN TRAN 

	UPDATE PROJETO.Pedido_Deslocação -- update na tabela PROJETO.Pedido_Deslocação os atributos ID_Superior e [Status] apenas no pedido de deslocação desejado 
	SET ID_Superior = @ID_Superior, [Status] = @Status
	WHERE ID_Pedido_Deslocação = @ID_Pedido_Deslocação
	COMMIT TRAN
	RETURN
GO

CREATE OR ALTER PROC PROJETO.SP_Submeter_Pedido_Reembolso -- Stored procedure para submeter um pedido de reembolso 
	@Nome_Colaborador varchar(100) 
	,@Mês varchar(20) 
	,@Ano int 
	,@Observações varchar(300)
	
AS
BEGIN TRAN
	DECLARE @ID_Colaborador int
	DECLARE @Month tinyint

	SELECT @ID_Colaborador = pd.ID_Colaborador
	FROM PROJETO.Pedido_Deslocação as pd
	left join PROJETO.Colaborador as c on pd.ID_Colaborador = c.ID_Colaborador
	WHERE c.Nome = @Nome_Colaborador

	SELECT @Month = ID_Mês
	FROM PROJETO.Mês
	WHERE LOWER(Designação_Mês) = LOWER(@Mês)

	DECLARE @Prox_ID_PR int 
	SELECT @Prox_ID_PR = (MAX(ID_Pedido_Reembolso) + 1)
	FROM PROJETO.Pedido_Reembolso
	IF @Prox_ID_PR IS NULL 
	BEGIN
	SET @Prox_ID_PR = 1
	END 

	INSERT INTO PROJETO.Pedido_Reembolso(ID_Pedido_Reembolso, Nº_Pedido, ID_Colaborador, ID_Mês, Data_Preenchimento_Reembolso, Serviço, ID_Origem, ID_Destino, Data_Início, Data_Fim, 
	ID_Tipo_Transporte, Importância_Total, Observações)
	SELECT @Prox_ID_PR, pd.ID_Pedido_Deslocação, pd.ID_Colaborador, @Month, GETDATE(), pd.Serviço, pd.ID_Origem, pd.ID_Destino, pd.Data_Início, pd.Data_Fim, 
	pd.ID_Tipo_Transporte, COALESCE(pd.Custo_Alojamento + pd.Custo_Inscrição, pd.Custo_Alojamento, pd.Custo_Inscrição, 0), @Observações FROM PROJETO.Pedido_Deslocação as pd
	WHERE pd.ID_Colaborador = @ID_Colaborador and @Month = MONTH(pd.Data_Início) and @Ano = YEAR(pd.Data_Início) and [Status] = 'Aprovado' and (SELECT COUNT(*) FROM PROJETO.Pedido_Reembolso 
	WHERE Nº_Pedido = pd.ID_Pedido_Deslocação) = 0
	

COMMIT TRAN
RETURN
GO

-- Trigger para garantir que só se pode preencher a descrição do apoio externo se for esse o tipo de financiamento escolhido

CREATE OR ALTER TRIGGER TR_Pedido_Deslocação_Status
ON PROJETO.Pedido_Deslocação
AFTER INSERT, UPDATE
AS
BEGIN TRAN
    -- Verifica se o status é "Recusado" e faz um raise error se o Pedido_Reembolso não for NULL
    IF EXISTS (
        SELECT 1
        FROM inserted I
        WHERE I.Status = 'Recusado' AND I.Pedido_Reembolso IS NOT NULL
    )
    BEGIN
        RAISERROR ('Não pode associar Pedido de Reembolso quando o Status é reprovado', 16, 1);
        ROLLBACK TRANSACTION; -- reverte a transação
        RETURN
    END
COMMIT TRAN
RETURN 


-- Trigger para garantir que a data do fim seja mais tarde que a data de início ou igual a esta

CREATE TRIGGER TRG_PedidoDeslocaçãoDataCheck
ON PROJETO.Pedido_Deslocação
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE Data_Fim <= Data_Início
    )
    BEGIN -- caso a data do fim seja antes da data de início, o trigger dispara e envia uma mensagem de erro ao user
        RAISERROR ('A data de fim não pode ser antes da data de início ou igual à data de início', 16, 1);
        ROLLBACK TRANSACTION; -- e reverte a transação
        RETURN;
    END;
END;

-- Trigger para garantir que só se pode preencher a descrição do apoio externo se for esse o tipo de financiamento escolhido

CREATE TRIGGER TRG_PedidoDeslocação_DescricaoApoioExternoCheck
ON Pedido_Deslocação
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted i
               INNER JOIN Tipo_Financiamento tf ON i.ID_Tipo_Financiamento = tf.ID_Tipo_Financiamento
               WHERE tf.Designação_Tipo_Financiamento <> 'Outro apoio externo' AND i.Descrição_Apoio_Externo IS NOT NULL)
    BEGIN -- caso se tente preencher a descrição do apoio externo sem ser esse o tipo de financiamento escolhido, o trigger dispara e envia uma mensagem de erro ao user
        RAISERROR ('Só é permitido preencher a coluna Descrição_Apoio_Externo se o Tipo_Financiamento for Outro Apoio Externo.', 16, 2); 
        ROLLBACK TRANSACTION; -- e reverte a transação
    END
END;

-- Trigger para inserir automaticamente a data de preenchimento na tabela Pedido_Deslocação

CREATE TRIGGER TRG_PedidoDeslocação_DataPreenchimento
ON PROJETO.Pedido_Deslocação
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO PROJETO.Pedido_Deslocação (ID_Pedido_Deslocação, ID_Pedido_Reembolso, Data_Preenchimento_Deslocação, ID_Colaborador, Serviço, 
	ID_Origem, ID_Destino, Data_Início, Data_Fim, ID_Tipo_Financiamento, Descrição_Apoio_Externo, ID_Tipo_Transporte, Custo_Inscrição, Custo_Alojamento, Num_Refeições, ID_Superior, Status)
    SELECT ID_Pedido_Deslocação, ID_Pedido_Reembolso, GETDATE(), ID_Colaborador, Serviço, ID_Origem, ID_Destino, Data_Início, Data_Fim, ID_Tipo_Financiamento, 
	Descrição_Apoio_Externo, ID_Tipo_Transporte, Custo_Inscrição, Custo_Alojamento, Num_Refeições, ID_Superior, Status
    FROM inserted;
END;
GO


-- Trigger para inserir automaticamente a data de preenchimento na tabela Pedido_Reembolso

CREATE TRIGGER TRG_PedidoReembolso_DataPreenchimento
ON PROJETO.Pedido_Reembolso
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO PROJETO.Pedido_Reembolso (ID_Pedido_Reembolso, Nº_Pedido, ID_Colaborador, ID_Mês, Data_Preenchimento_Reembolso, Serviço, ID_Origem, 
	ID_Destino, Data_Início, Data_Fim, Hora_Partida, Hora_Chegada, ID_Tipo_Transporte, Importância_Total, Observações)
    SELECT ID_Pedido_Reembolso, Nº_Pedido, ID_Colaborador, ID_Mês, GETDATE(), Serviço, ID_Origem, ID_Destino, Data_Início, Data_Fim, Hora_Partida, Hora_Chegada, 
	ID_Tipo_Transporte, Importância_Total, Observações
    FROM inserted;
END;
GO

-- View para permitir listar todos os pedidos de deslocação por cada colaborador


CREATE VIEW VW_Pedidos_de_Deslocacao_Por_Colaborador 
AS
	SELECT C.ID_Colaborador AS IDColaborador
		,C.Nome AS NomeColaborador
		,C.Departamento AS Departamento
		,PD.ID_Pedido_Deslocação AS IDPedidoDeslocação
	FROM PROJETO.Colaborador C
	INNER JOIN PROJETO.Pedido_Deslocação PD ON C.ID_Colaborador = PD.ID_Colaborador;
GO

SELECT * FROM VW_Pedidos_de_Deslocacao_Por_Colaborador
GO

-- View para permitir listar o mês em que o pedidos de reembolso foram feitos, bem como o nome do colaborador 

CREATE VIEW VW_Meses_Nomes_Pedidos_Reembolso
AS
	SELECT PR.ID_Pedido_Reembolso AS IDPedidoReembolso
		, PR.Nº_Pedido AS NúmeroPedido
		, M.Designação_Mês AS Mês
	FROM PROJETO.Mês M
	INNER JOIN PROJETO.Pedido_Reembolso PR ON M.ID_Mês = PR.ID_Mês

GO

SELECT * FROM VW_Meses_Nomes_Pedidos_Reembolso
GO


-- View para permitir listar todos os pedidos de deslocação aprovados


CREATE VIEW VW_Pedidos_Deslocação_Aprovados
AS
	SELECT *
	FROM PROJETO.Pedido_Deslocação
	WHERE Status = 'Aprovado'

GO

SELECT * FROM VW_Pedidos_Deslocação_Aprovados
GO


-- View para permitir listar todos os pedidos de deslocação reprovados


CREATE VIEW VW_Pedidos_Deslocação_Recusados
AS
	SELECT *
	FROM PROJETO.Pedido_Deslocação
	WHERE Status = 'Recusado'

GO

SELECT * FROM VW_Pedidos_Deslocação_Recusados
GO


-- View para permitir listar todos os pedidos de reembolso por cada colaborador


CREATE VIEW VW_Pedidos_de_Reembolso_Por_Colaborador 
AS
	SELECT PR.ID_Pedido_Reembolso AS IDPedidoReembolso
	,PR.Nº_Pedido AS NumeroPedidoReembolso
	,C.ID_Colaborador AS IDColaborador
	,C.Nome AS NomeColaborador
	,C.Departamento AS Departamento
	FROM PROJETO.Colaborador C
		INNER JOIN PROJETO.Pedido_Reembolso PR ON C.ID_Colaborador = PR.ID_Colaborador

GO

SELECT * FROM VW_Pedidos_de_Reembolso_Por_Colaborador
GO