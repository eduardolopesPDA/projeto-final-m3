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
    data DATE DEFAULT CURRENT_DATE,
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
    data DATE DEFAULT CURRENT_DATE,
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