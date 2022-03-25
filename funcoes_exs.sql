CREATE DATABASE funcionarios
USE funcionarios;

DROP TABLE funcionario;

CREATE TABLE funcionario(
	codigo INT PRIMARY KEY IDENTITY(1, 1),
	nome VARCHAR(100) NOT NULL,
	salario DECIMAL NOT NULL
)

DROP TABLE dependentes;

CREATE TABLE dependentes(
	codigo_funcionario INT FOREIGN KEY REFERENCES funcionario(codigo),
	nome_dependente VARCHAR(100) NOT NULL,
	salario_dependente DECIMAL NOT NULL	
)

INSERT INTO funcionario (nome, salario) VALUES
('Maykeee', 2000.90),
('Felipe', 1223.90),
('Mendoza', 2500.80),
('Huanca', 3000.76),
('Juliana', 1789.09),
('Patricia', 1872.26);

SELECT * FROM funcionario 

INSERT INTO dependentes (codigo_funcionario, nome_dependente, salario_dependente) VALUES
(1, 'dep1', 210.99),
(1, 'dep2', 220.99),
(1, 'dep3', 230.99),

(2, 'dep4', 240.99),
(2, 'dep5', 250.99),
(2, 'dep6', 260.99),

(3, 'dep7', 270.99),
(3, 'dep8', 280.99),
(3, 'dep9', 290.99),

(4, 'dep10', 300.99),
(4, 'dep11', 310.99),
(4, 'dep12', 320.99),

(5, 'dep13', 330.99),
(5, 'dep14', 340.99),
(5, 'dep15', 350.99),

(6, 'dep16', 360.99),
(6, 'dep17', 370.99),
(6, 'dep18', 380.99);


-- a) Uma Function que Retorne uma tabela:
-- (Nome_Funcionário, Nome_Dependente, Salário_Funcionário, Salário_Dependente)

CREATE FUNCTION ex1()
RETURNS @tabela TABLE(
	funcionario VARCHAR(100), 
	dependente VARCHAR(100),
	salario_funcionario DECIMAL(10, 2),
	salario_dependete DECIMAL(10, 2)
)
AS
BEGIN
	INSERT INTO @tabela (funcionario, dependente, salario_funcionario, salario_dependete)
	SELECT nome, nome_dependente, salario, salario_dependente 
	FROM funcionario, dependentes
	WHERE codigo = codigo_funcionario 
	RETURN
END

SELECT * FROM dbo.ex1();

-- b) Uma Scalar Function que Retorne a soma dos Salários dos dependentes, mais a do funcionário.

CREATE FUNCTION ex2 (@codFunc INT)
RETURNS DECIMAL 
AS
BEGIN
	DECLARE @somaSalarioDependentes DECIMAL (10, 2),
			@salarioFuncionario DECIMAL(10, 2);
		
	SELECT @somaSalarioDependentes = SUM(salario_dependente) FROM dependentes WHERE codigo_funcionario = @codFunc;
	SELECT @salarioFuncionario = salario FROM funcionario WHERE codigo = @codFunc;
	
	RETURN (@somaSalarioDependentes + @salarioFuncionario);
END

SELECT dbo.ex2(2) AS resultado;
