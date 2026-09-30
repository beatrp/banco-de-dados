CREATE TABLE itens_vendas(
	fk_vendas INTEGER NOT NULL REFERENCES vendas(numero),
	fk_produto INTEGER NOT NULL REFERENCES produtos(cod),
	quantidade INTEGER CHECK (quantidade > 0),
	PRIMARY KEY (fk_vendas, fk_produto)
);