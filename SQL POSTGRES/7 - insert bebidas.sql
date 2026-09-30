INSERT INTO categoria (descricao) VALUES ('Alimentos');

SELECT * FROM categoria; 

UPDATE categoria SET descricao = 'Bebidas' WHERE id = 2;

ALTER TABLE categoria RENAME COLUMN descri TO descricao;
