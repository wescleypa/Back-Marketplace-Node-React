// src/app.js
const express = require('express');
const cors = require('cors');
const apiRoutes = require('./routes/api'); // Importação das rotas
const logger = require('./utils/logger');

const app = express();

// Middlewares
app.use(cors());
app.use(express.json());

// Rotas
app.use('/api', apiRoutes); // Prefixo /api aplicado aqui

// Middleware de erro
app.use((err, req, res, next) => {
  logger.error(err.stack);
  res.status(500).send('Something broke!');
});

module.exports = app;