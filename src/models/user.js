// User.js
const pool = require('../config/db');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');

class User {
  static async create(data) {
    const { name, email, password } = data;

    // Criptografa a senha
    const hashedPassword = await bcrypt.hash(password, 10);

    // Insere o usuário no banco de dados
    const [result] = await pool.execute(
      'INSERT INTO users (name, email, password) VALUES (?, ?, ?)',
      [name, email, hashedPassword]
    );

    // Gera o token JWT
    const token = jwt.sign(
      { userId: result.insertId, email },
      'your-secret-key', // Use uma chave secreta forte em produção
      { expiresIn: '1h' }
    );

    // Retorna o token e algumas informações do usuário
    return {
      userId: result.insertId,
      name,
      email,
      token
    };
  }

  static async login(data) {
    const { email, password } = data;

    // Busca o usuário pelo e-mail
    const [users] = await pool.execute(
      'SELECT * FROM users WHERE email = ?',
      [email]
    );

    // Verifica se o usuário existe
    if (users.length === 0) {
      throw new Error('Usuário não encontrado');
    }

    const user = users[0];

    // Compara a senha fornecida com a senha armazenada (hash)
    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      throw new Error('Senha incorreta');
    }

    // Gera o token JWT
    const token = jwt.sign(
      { userId: user.id, email: user.email },
      'your-secret-key', // Use a mesma chave secreta usada no create
      { expiresIn: '1h' }
    );

    // Busca os dados do carrinho do usuário (LEFT JOIN com user_cart)
    const [userCart] = await pool.execute(
      `SELECT 
        users.id AS userId,
        users.name,
        users.email,
        user_cart.title,
        user_cart.price,
        user_cart.image,
        user_cart.rating,
        user_cart.link,
        user_cart.product as id,
        user_cart.discount,
        user_cart.originalPrice
      FROM users
      LEFT JOIN user_cart ON users.id = user_cart.user
      WHERE users.id = ?`,
      [user.id]
    );

    // Formata os dados do carrinho
    const cart = userCart.map((item) => ({
      id: item.id,
      title: item.title,
      price: item.price,
      image: item.image,
      rating: item.rating,
      link: item.link,
      discount: item.discount,
      originalPrice: item.originalPrice,
    }));

    // Retorna o token, informações do usuário e dados do carrinho
    return {
      userId: user.id,
      name: user.name,
      email: user.email,
      token,
      cart
    };
  }
}

module.exports = User;