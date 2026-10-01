INSERT INTO produtos (nome, preco, qtd_estoque, fk_categoria)
VALUES ('Arroz', 25.90,40,2);

SELECT * FROM produtos; 

INSERT INTO categoria (id, descricao) VALUES (2, 'Nome da Categoria');
SELECT * FROM categoria;

INSERT INTO vendedor (cod, nome, endereco, cidade, estado, telefone, perc_comissao)
VALUES ('1','fulano', 'bairro do limoeiro', 'itape', 'sp','999999999', '5.0' );

SELECT * FROM vendedor;

INSERT INTO cliente (codigo, nome, endereco, cidade, estado, email, cpf, limite_cred)
VALUES ('6', 'RELOKIT', 'naosei')
