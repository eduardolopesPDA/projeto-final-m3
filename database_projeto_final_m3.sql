CREATE DATABASE projeto_final_m3;

USE projeto_final_m3;



CREATE TABLE usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    endereco VARCHAR(100),
    email VARCHAR(100),
    senha VARCHAR(100),
    telefone CHAR(11),
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE categoria (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    descricao TEXT,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE produto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuarios INT,
    id_categoria INT,
    nome VARCHAR(100),
    descricao TEXT,
    preco DECIMAL(10,2),
    estoque INT,
    marca VARCHAR(100),
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuarios) REFERENCES usuarios(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE catalogo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuarios INT,
    nome VARCHAR(100),
    descricao TEXT,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuarios) REFERENCES usuarios(id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE carrinho (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuarios INT,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuarios) REFERENCES usuarios(id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE item_carrinho (
    id INT PRIMARY KEY AUTO_INCREMENT,
    carrinho_id INT,
    produto_id INT,
    preco_unitario DECIMAL(10,2),
    quantidade INT,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (carrinho_id) REFERENCES carrinho(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produto(id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE compra (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuarios INT,
    data TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10,2),
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuarios) REFERENCES usuarios(id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE pagamento (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuarios INT,
    compra_id INT,
    tipo VARCHAR(50),
    valor DECIMAL(10,2),
    data TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuarios) REFERENCES usuarios(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (compra_id) REFERENCES compra(id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE entrega (
    id INT PRIMARY KEY AUTO_INCREMENT,
    compra_id INT,
    endereco VARCHAR(255),
    data_prevista DATE,
    data_entrega DATE,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (compra_id) REFERENCES compra(id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE avaliacao (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuarios INT,
    produto_id INT,
    nota INT CHECK(nota BETWEEN 1 AND 5),
    comentario TEXT,
    data TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuarios) REFERENCES usuarios(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produto(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE chat (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuarios INT,
    nome VARCHAR(100),
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuarios) REFERENCES usuarios(id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE moderacao (
    id INT PRIMARY KEY AUTO_INCREMENT,
    chat_id INT,
    avaliacao_id INT,
    produto_id INT,
   data TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    motivo TEXT NOT NULL,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (chat_id) REFERENCES chat(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (avaliacao_id) REFERENCES avaliacao(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produto(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- inserir dados na tabela `usuarios`
DELIMITER //
CREATE PROCEDURE InserirUsuario(
    IN p_nome VARCHAR(100),
    IN p_endereco VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_senha VARCHAR(100),
    IN p_telefone CHAR(11)
)
BEGIN
    INSERT INTO usuarios (nome, endereco, email, senha, telefone)
    VALUES (p_nome, p_endereco, p_email, p_senha, p_telefone);
END //
DELIMITER ;

-- inserir dados na tabela `categoria`
DELIMITER //
CREATE PROCEDURE InserirCategoria(
    IN p_nome VARCHAR(100),
    IN p_descricao TEXT
)
BEGIN
    INSERT INTO categoria (nome, descricao)
    VALUES (p_nome, p_descricao);
END //
DELIMITER ;

-- inserir dados na tabela `produto`
DELIMITER //
CREATE PROCEDURE InserirProduto(
    IN p_id_usuarios INT,
    IN p_id_categoria INT,
    IN p_nome VARCHAR(100),
    IN p_descricao TEXT,
    IN p_preco DECIMAL(10,2),
    IN p_estoque INT,
    IN p_marca VARCHAR(100)
)
BEGIN
    INSERT INTO produto (id_usuarios, id_categoria, nome, descricao, preco, estoque, marca)
    VALUES (p_id_usuarios, p_id_categoria, p_nome, p_descricao, p_preco, p_estoque, p_marca);
END //
DELIMITER ;

-- inserir dados na tabela `catalogo`
DELIMITER //
CREATE PROCEDURE InserirCatalogo(
    IN p_id_usuarios INT,
    IN p_nome VARCHAR(100),
    IN p_descricao TEXT
)
BEGIN
    INSERT INTO catalogo (id_usuarios, nome, descricao)
    VALUES (p_id_usuarios, p_nome, p_descricao);
END //
DELIMITER ;

-- inserir dados na tabela `carrinho`
DELIMITER //
CREATE PROCEDURE InserirCarrinho(
    IN p_id_usuarios INT
)
BEGIN
    INSERT INTO carrinho (id_usuarios)
    VALUES (p_id_usuarios);
END //
DELIMITER ;

-- inserir dados na tabela `item_carrinho`
DELIMITER //
CREATE PROCEDURE InserirItemCarrinho(
    IN p_carrinho_id INT,
    IN p_produto_id INT,
    IN p_preco_unitario DECIMAL(10,2),
    IN p_quantidade INT
)
BEGIN
    INSERT INTO item_carrinho (carrinho_id, produto_id, preco_unitario, quantidade)
    VALUES (p_carrinho_id, p_produto_id, p_preco_unitario, p_quantidade);
END //
DELIMITER ;

-- inserir dados na tabela `compra`
DELIMITER //
CREATE PROCEDURE InserirCompra(
    IN p_id_usuarios INT,
    IN p_valor_total DECIMAL(10,2)
)
BEGIN
    INSERT INTO compra (id_usuarios, valor_total)
    VALUES (p_id_usuarios, p_valor_total);
END //
DELIMITER ;

-- inserir dados na tabela `pagamento`
DELIMITER //
CREATE PROCEDURE InserirPagamento(
    IN p_id_usuarios INT,
    IN p_compra_id INT,
    IN p_tipo VARCHAR(50),
    IN p_valor DECIMAL(10,2)
)
BEGIN
    INSERT INTO pagamento (id_usuarios, compra_id, tipo, valor)
    VALUES (p_id_usuarios, p_compra_id, p_tipo, p_valor);
END //
DELIMITER ;

-- inserir dados na tabela `entrega`
DELIMITER //
CREATE PROCEDURE InserirEntrega(
    IN p_compra_id INT,
    IN p_endereco VARCHAR(255),
    IN p_data_prevista DATE,
    IN p_data_entrega DATE
)
BEGIN
    INSERT INTO entrega (compra_id, endereco, data_prevista, data_entrega)
    VALUES (p_compra_id, p_endereco, p_data_prevista, p_data_entrega);
END //
DELIMITER ;

DELIMITER //

-- inserir dados na tabela `avaliacao`
DELIMITER //
CREATE PROCEDURE InserirAvaliacao(
    IN p_id_usuarios INT,
    IN p_produto_id INT,
    IN p_nota INT,
    IN p_comentario TEXT
)
BEGIN
    INSERT INTO avaliacao (id_usuarios, produto_id, nota, comentario)
    VALUES (p_id_usuarios, p_produto_id, p_nota, p_comentario);
END //
DELIMITER ;

-- inserir dados na tabela `chat`
DELIMITER //
CREATE PROCEDURE InserirChat(
    IN p_id_usuarios INT,
    IN p_nome VARCHAR(100)
)
BEGIN
    INSERT INTO chat (id_usuarios, nome)
    VALUES (p_id_usuarios, p_nome);
END //
DELIMITER ;

-- inserir dados na tabela `moderacao`
DELIMITER //
CREATE PROCEDURE InserirModeracao(
    IN p_chat_id INT,
    IN p_avaliacao_id INT,
    IN p_produto_id INT,
    IN p_motivo TEXT
)
BEGIN
    INSERT INTO moderacao (chat_id, avaliacao_id, produto_id, motivo)
    VALUES (p_chat_id, p_avaliacao_id, p_produto_id, p_motivo);
END //
DELIMITER ;
CALL InserirUsuario('João Silva', 'Rua A, 123', 'joao@email.com', 'senha123', '11987654321');
CALL InserirUsuario('Maria Oliveira', 'Rua B, 456', 'maria@email.com', 'senha456', '11987654322');
CALL InserirUsuario('Carlos Souza', 'Rua C, 789', 'carlos@email.com', 'senha789', '11987654323');
CALL InserirUsuario('Ana Lima', 'Rua D, 101', 'ana@email.com', 'senha101', '11987654324');
CALL InserirUsuario('Pedro Santos', 'Rua E, 202', 'pedro@email.com', 'senha202', '11987654325');
CALL InserirUsuario('Fernanda Costa', 'Rua F, 303', 'fernanda@email.com', 'senha303', '11987654326');
CALL InserirUsuario('Ricardo Mendes', 'Rua G, 404', 'ricardo@email.com', 'senha404', '11987654327');
CALL InserirUsuario('Juliana Martins', 'Rua H, 505', 'juliana@email.com', 'senha505', '11987654328');
CALL InserirUsuario('Lucas Rocha', 'Rua I, 606', 'lucas@email.com', 'senha606', '11987654329');
CALL InserirUsuario('Carla Ferreira', 'Rua J, 707', 'carla@email.com', 'senha707', '11987654330');
-- 2
CALL InserirCategoria('Eletrônicos', 'Aparelhos eletrônicos em geral');
CALL InserirCategoria('Celulares', 'Smartphones e acessórios');
CALL InserirCategoria('Computadores', 'Desktops, notebooks e acessórios');
CALL InserirCategoria('TVs', 'Televisores, 4K, LED, Smart TVs');
CALL InserirCategoria('Áudio e Som', 'Caixas de som, fones de ouvido e sistemas de áudio');
CALL InserirCategoria('Câmeras', 'Câmeras digitais e câmeras de segurança');
CALL InserirCategoria('Eletroportáteis', 'Pequenos eletrodomésticos como liquidificadores, cafeteiras e ferros de passar');
CALL InserirCategoria('Gaming', 'Consoles, jogos e acessórios de videogame');

CALL InserirCatalogo(1, 'Liquidificadores', 'Os melhores modelos para sua cozinha');
CALL InserirCatalogo(2, 'Cafeteiras', 'Prepare um café delicioso todos os dias');
CALL InserirCatalogo(3, 'Fritadeiras Elétricas', 'Praticidade e sabor sem óleo');
CALL InserirCatalogo(4, 'Aspiradores de Pó', 'Mantenha sua casa sempre limpa');
CALL InserirCatalogo(5, 'Ferro de Passar', 'Roupas sempre impecáveis com facilidade');
CALL InserirCatalogo(6, 'Batedeiras', 'Facilite suas receitas com eficiência');
CALL InserirCatalogo(7, 'Sanduicheiras', 'Lanches rápidos e saborosos');
CALL InserirCatalogo(8, 'Purificadores de Água', 'Água limpa e saudável todos os dias');
CALL InserirCatalogo(9, 'Forno Elétrico', 'Mais praticidade no preparo das refeições');
CALL InserirCatalogo(10, 'Micro-ondas', 'Esquente e prepare alimentos rapidamente');

-- 4
CALL InserirProduto(21, 4, 'Máquina de Lavar 7kg', 'Lavadora automática com 7kg de capacidade e 8 programas', 1299.90, 15, 'Marca L');
CALL InserirProduto(22, 4, 'Máquina de Lavar 10kg', 'Lavadora de roupas com capacidade para 10kg e painel digital', 1799.90, 20, 'Marca M');
CALL InserirProduto(23, 4, 'Máquina de Lavar 12kg', 'Máquina de lavar com 12kg de capacidade e tecnologia de lavagem rápida', 2299.90, 10, 'Marca N');
CALL InserirProduto(24, 4, 'Máquina de Lavar 15kg', 'Lavadora com 15kg de capacidade e economia de água', 2899.90, 12, 'Marca O');
CALL InserirProduto(25, 4, 'Máquina de Lavar 8kg', 'Lavadora automática com 8kg e sistema anti-formiga', 1499.90, 25, 'Marca P');
CALL InserirProduto(26, 4, 'Máquina de Lavar 18kg', 'Lavadora industrial com capacidade de 18kg e função turbo', 3499.90, 8, 'Marca Q');
CALL InserirProduto(27, 4, 'Máquina de Lavar 11kg', 'Lavadora 11kg com tecnologia Eco Bubble', 1999.90, 18, 'Marca R');
CALL InserirProduto(28, 4, 'Máquina de Lavar 9kg', 'Lavadora com 9kg de capacidade e painel de controle touch', 1699.90, 22, 'Marca S');






-- 5
CALL InserirCarrinho(1);
CALL InserirCarrinho(2);
CALL InserirCarrinho(3);
CALL InserirCarrinho(4);
CALL InserirCarrinho(5);
CALL InserirCarrinho(6);
CALL InserirCarrinho(7);
CALL InserirCarrinho(8);
CALL InserirCarrinho(9);
CALL InserirCarrinho(10);
 
 
 -- 6
CALL InserirProduto(1, 1, 'Smartphone X', 'Celular de última geração', 2500.00, 10, 'Marca A');
CALL InserirProduto(2, 1, 'Notebook Ultra', 'Notebook leve e potente', 4500.00, 8, 'Marca B');
CALL InserirProduto(3, 1, 'Fone de Ouvido Bluetooth', 'Som de alta qualidade sem fio', 299.90, 25, 'Marca C');
CALL InserirProduto(4, 1, 'Smart TV 55"', 'Televisão 4K com HDR', 3200.00, 12, 'Marca D');
CALL InserirProduto(5, 1, 'Console de Videogame', 'Última geração de console', 3500.00, 15, 'Marca E');
CALL InserirProduto(6, 1, 'Tablet Pro', 'Tablet com caneta digital', 2800.00, 10, 'Marca F');
CALL InserirProduto(7, 1, 'Câmera DSLR', 'Câmera profissional com lente 18-55mm', 5200.00, 5, 'Marca G');
CALL InserirProduto(8, 1, 'Mouse Gamer', 'Mouse RGB com DPI ajustável', 150.00, 40, 'Marca H');
CALL InserirProduto(9, 1, 'Roteador Wi-Fi 6', 'Alta velocidade e maior alcance', 350.00, 20, 'Marca I');
CALL InserirProduto(10, 1, 'Carregador Portátil 20.000mAh', 'Bateria externa de alta capacidade', 180.00, 30, 'Marca J');



-- 7
CALL InserirCompra(1, 5000.00);
CALL InserirCompra(2, 200.00);
CALL InserirCompra(3, 77.50);
CALL InserirCompra(4, 150.00);
CALL InserirCompra(5, 320.00);
CALL InserirCompra(6, 1800.00);
CALL InserirCompra(7, 270.00);
CALL InserirCompra(8, 200.00);
CALL InserirCompra(9, 89.90);
CALL InserirCompra(10, 300.00);

-- 8
CALL InserirEntrega(1, 'Rua A, 123', '2025-03-15', '2025-03-20');
 -- CALL InserirEntrega(2, 'Rua B, 456', '2025-03-16', '2025-03-26'); 
CALL InserirEntrega(3, 'Rua C, 789', '2025-03-17', '2025-03-23');
CALL InserirEntrega(4, 'Rua D, 101', '2025-03-18', '2025-03-27');
CALL InserirEntrega(5, 'Rua E, 202', '2025-03-19', '2025-03-24');
CALL InserirEntrega(6, 'Rua F, 303', '2025-03-20', '2025-03-30');
CALL InserirEntrega(7, 'Rua G, 404', '2025-03-21', '2025-03-29');
CALL InserirEntrega(8, 'Rua H, 505', '2025-03-22', '2025-03-28');
CALL InserirEntrega(9, 'Rua I, 606', '2025-03-23', '2025-03-31');
CALL InserirEntrega(10, 'Rua J, 707', '2025-03-24', '2025-04-01');


-- 9
CALL InserirAvaliacao(1, 1, 5, 'Ótimo');
CALL InserirAvaliacao(2, 2, 4, 'Bom');
CALL InserirAvaliacao(3, 3, 3, 'Médio');
CALL InserirAvaliacao(4, 4, 5, 'Ótimo');
CALL InserirAvaliacao(5, 5, 4, 'Bom');
CALL InserirAvaliacao(6, 6, 5, 'Ótimo');
CALL InserirAvaliacao(7, 7, 3, 'Médio');
CALL InserirAvaliacao(8, 8, 4, 'Bom');
CALL InserirAvaliacao(9, 9, 2, 'Ruim');
CALL InserirAvaliacao(10, 10, 3, 'Ok');



-- 10 
CALL InserirPagamento(1, 1, 'Cartão de Crédito', 5000.00);
-- CALL InserirPagamento(2, 2, 'Boleto', 200.00);
CALL InserirPagamento(3, 3, 'Pix', 77.50);
CALL InserirPagamento(4, 4, 'Cartão de Débito', 150.00);
CALL InserirPagamento(5, 5, 'Cartão de Crédito', 320.00);
CALL InserirPagamento(6, 6, 'Boleto', 1800.00);
CALL InserirPagamento(7, 7, 'Pix', 270.00);
CALL InserirPagamento(8, 8, 'Cartão de Débito', 200.00);
CALL InserirPagamento(9, 9, 'Pix', 89.90);
CALL InserirPagamento(10, 10, 'Cartão de Crédito', 300.00);


-- produto que foi enviado entre as data 1 entre 31
SELECT * FROM entrega WHERE data_prevista BETWEEN '2025-03-01' AND '2025-03-31';


-- Esta consulta retorna produtos que foram comprados, ou seja, que estão na tabela item_carrinho e possuem uma compra associada.
SELECT DISTINCT p.id, p.nome, p.descricao, p.preco, p.estoque, p.marca
FROM produto p
JOIN item_carrinho ic ON p.id = ic.produto_id
JOIN compra c ON ic.carrinho_id = c.id_usuarios;

-- lista uma avaliação de uma pessoa em um produto especifico 
SELECT u.nome, a.nota, a.comentario 
FROM avaliacao a
JOIN usuarios u ON a.id_usuarios = u.id
WHERE a.produto_id = 1;

-- lista todos os usuários cadastrados
SELECT id, nome, email, telefone, data_criacao FROM usuarios;

-- lista todas as compras realizadas e os usuários que as fizeram.
SELECT compra.id AS ID_Compra, usuarios.nome AS Cliente, compra.valor_total, compra.data
FROM compra
INNER JOIN usuarios ON compra.id_usuarios = usuarios.id;

-- lista a quantidade de produtos em cada categoria
SELECT c.nome AS categoria, COUNT(p.id) AS total_produtos
FROM categoria c
LEFT JOIN produto p ON c.id = p.id_categoria
GROUP BY c.nome;

-- produtos categorias e donos
SELECT p.id, p.nome AS produto, p.descricao, p.preco, p.estoque, c.nome AS categoria, u.nome AS dono
FROM produto p
JOIN categoria c ON p.id_categoria = c.id
JOIN usuarios u ON p.id_usuarios = u.id;

-- usuarios data da compra e valor total da compra 
SELECT co.id, u.nome AS usuario, co.data, co.valor_total
FROM compra co
JOIN usuarios u ON co.id_usuarios = u.id
ORDER BY co.data DESC;

-- produtos nota e total de avaliações 
SELECT p.nome AS produto, AVG(a.nota) AS media_nota, COUNT(a.id) AS total_avaliacoes
FROM avaliacao a
JOIN produto p ON a.produto_id = p.id
GROUP BY p.id, p.nome
ORDER BY media_nota DESC;