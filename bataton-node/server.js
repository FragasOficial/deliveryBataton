// server.js
const express = require('express');
const mysql = require('mysql2');
const dotenv = require('dotenv');

// Carregar variáveis de ambiente
dotenv.config();

const app = express();
const port = process.env.PORT || 3000;

// Configurar o middleware para analisar os dados do formulário
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Configuração do banco de dados MySQL
const db = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

// Conectar ao banco de dados
db.connect((err) => {
  if (err) {
    console.error('Erro ao conectar ao banco de dados: ', err);
    return;
  }
  console.log('Conectado ao banco de dados MySQL');
});

// Rota principal para o menu
app.get('/produtos', (req, res) => {
  const sql = 'SELECT * FROM Produtos';
  db.query(sql, (err, result) => {
    if (err) throw err;
    res.json(result);
  });
});

// Rota para receber pedidos
app.post('/pedidos', (req, res) => {
  const { nome_cliente, telefone_cliente, endereco_cliente, total, produto_id, refrigerante_id, quantidade } = req.body;
  
  // Primeiro, insere o pedido
  const pedidoSql = `INSERT INTO Pedidos (nome_cliente, telefone_cliente, endereco_cliente, total) VALUES (?, ?, ?, ?)`;
  db.query(pedidoSql, [nome_cliente, telefone_cliente, endereco_cliente, total], (err, result) => {
    if (err) throw err;
    
    const pedidoId = result.insertId;

    // Agora, insere os itens do pedido
    const itemSql = `INSERT INTO Itens_Pedido (pedido_id, produto_id, refrigerante_id, quantidade, preco_unitario) VALUES (?, ?, ?, ?, ?)`;
    db.query(itemSql, [pedidoId, produto_id, refrigerante_id, quantidade, total], (err, result) => {
      if (err) throw err;
      res.send('Pedido realizado com sucesso!');
    });
  });
});

// Iniciar o servidor
app.listen(port, () => {
  console.log(`Servidor rodando na porta ${port}`);
});
