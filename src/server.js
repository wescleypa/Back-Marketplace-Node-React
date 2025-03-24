// src/server.js
const http = require('http');
const app = require('./app');
const logger = require('./utils/logger');
const socketConfig = require('./config/socket');
const SearchService = require('./services/searchService');
const ProductService = require('./services/productService');
const User = require('./models/user');
require('dotenv').config();

const server = http.createServer(app);
const io = socketConfig.init(server);

// Eventos do Socket.IO
io.on('connection', (socket) => {
  logger.info('New client connected');

  // Evento para buscar produtos no Mercado Livre
  socket.on('search', async (query, callback) => {
    try {
      const products = await SearchService.searchMercadoLivre(query);
      console.log(products);
      callback({ status: 'success', data: products });
    } catch (error) {
      callback({ status: 'error', message: error.message });
    }
  });

  socket.on('search_by_page', async (data, callback) => {
    const { search, val } = data;

    try {
      const products = await SearchService.searchMercadoLivre(search, val);
      callback({ status: 'success', data: products });
    } catch (error) {
      callback({ status: 'error', message: error.message });
    }
  });

  socket.on('getProduct', async (product, callback) => {
    try {
      const result = await ProductService.getProduct(product);
      callback({ status: 'success', data: result });
    } catch (error) {
      callback({ status: 'error', message: error.message });
    }
  });

  socket.on('register', async (data, callback) => {
    try {
      const result = await User.create(data);
      callback({ status: 'success', data: result });
    } catch (error) {
      console.error(error);
      callback({ status: 'error', message: error.message });
    }
  });

  socket.on('login', async (data, callback) => {
    try {
      const result = await User.login(data);
      callback({ status: 'success', data: result });
    } catch (error) {
      console.error(error);
      callback({ status: 'error', message: error.message });
    }
  });

  socket.on('addToCart', async (data, callback) => {
    try {
      const result = await ProductService.addToCart(data);
      console.log(result);
      callback({ status: 'success', data: result });
    } catch (error) {
      console.error(error);
      callback({ status: 'error', message: error.message });
    }
  });

  socket.on('disconnect', () => {
    logger.info('Client disconnected');
  });
});

const PORT = process.env.PORT || 7000;
server.listen(PORT, () => {
  logger.info(`Server running on port ${PORT}`);
});