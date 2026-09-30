CREATE TABLE vendas(
	numero SERIAL PRIMARY KEY,
	data_venda DATE NOT NULL,
	prazo_entrega VARCHAR(50),
	cond_pgto VARCHAR(50) NOT NULL,
	fk_cliente INTEGER REFERENCES cliente(codigo),
	fk_vendedor INTEGER REFERENCES vendedor(cod)
);