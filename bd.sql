-- Criar o banco de dados
CREATE DATABASE bataton_db;
USE bataton_db;

-- Tabela Produtos (batatas fritas e combos)
CREATE TABLE Produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    tipo VARCHAR(50) NOT NULL CHECK (tipo IN ('batata', 'combo')),
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inserir os produtos no banco
INSERT INTO Produtos (nome, descricao, preco, tipo) VALUES
('Batata Frita Tradicional', 'Crocante e deliciosa!', 12.00, 'batata'),
('Batata Frita com Bacon', 'Com bacon crocante por cima!', 15.00, 'batata'),
('Batata Frita com Calabresa', 'Acompanha calabresa especial.', 16.00, 'batata'),
('Combo Tradicional + Refrigerante', 'Batata tradicional com o refrigerante da sua escolha.', 20.00, 'combo'),
('Combo Bacon + Refrigerante', 'Batata com bacon e o refrigerante da sua escolha.', 22.00, 'combo');

-- Tabela Refrigerantes
CREATE TABLE Refrigerantes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(100) NOT NULL,
    tamanho_ml INT NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inserir os refrigerantes disponíveis
INSERT INTO Refrigerantes (marca, tamanho_ml) VALUES
('Coca-Cola', 600),
('Coca-Cola', 1000),
('Coca-Cola', 2000),
('Delrio', 600),
('Delrio', 1000),
('Delrio', 2000),
('Guaraná Antartica', 600),
('Guaraná Antartica', 1000),
('Guaraná Antartica', 2000);

-- Tabela Pedidos (para armazenar informações de pedidos)
CREATE TABLE Pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente VARCHAR(100) NOT NULL,
    telefone_cliente VARCHAR(20) NOT NULL,
    endereco_cliente VARCHAR(255) NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela Itens_Pedido (relaciona Produtos e Pedidos)
CREATE TABLE Itens_Pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    produto_id INT,
    refrigerante_id INT DEFAULT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES Produtos(id),
    FOREIGN KEY (refrigerante_id) REFERENCES Refrigerantes(id)
);
