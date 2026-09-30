CREATE TABLE vendedor(
	cod SERIAL PRIMARY KEY, 
	nome VARCHAR(100) NOT NULL,
	cidade VARCHAR(100) NOT NULL,
	endereco VARCHAR(100) NOT NULL,
	estado CHAR(2) NOT NULL,
	telefone VARCHAR(15),
	perc_comissao NUMERIC (5, 2), CHECK (perc_comissao >0)
);