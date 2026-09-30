CREATE TABLE produtos(
	cod SERIAL PRIMARY KEY,
	nome VARCHAR(150) NOT NULL,
	preco NUMERIC(12,2) CHECK (preco > 0),
	qtd_estoque INTEGER CHECK (qtd_estoque >= 0),
	fk_categoria INTEGER REFERENCES categoria(id)
);
