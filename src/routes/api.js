// src/routes/api.js
const express = require('express');
const ProductController = require('../controllers/productController');
const SearchController = require('../controllers/searchController');
const MercadopagoController = require('../controllers/mercadopagoController');
const MercadopagoService = require('../services/mercadoPagoService');

const router = express.Router();

// Rotas para produtos
router.get('/products', ProductController.getAll); // Rota GET /api/products
router.post('/products', ProductController.create); // Rota POST /api/products

// Rota para busca
router.get('/search', SearchController.search); // Rota GET /api/search?q=...

//mercado pago
router.post('/create_payment', MercadopagoController.createPreference);
router.post('/payment_credit', MercadopagoController.createCreditPay)
router.post('/webhook', MercadopagoService.webhook)

module.exports = router;