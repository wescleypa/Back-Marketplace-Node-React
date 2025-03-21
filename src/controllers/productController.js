const Product = require('../models/Product');

class ProductController {
  static async getAll(req, res) {
    try {
      const products = await Product.findAll();
      res.json(products);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }

  static async create(req, res) {
    try {
      const productId = await Product.create(req.body);
      res.status(201).json({ id: productId });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
}

module.exports = ProductController;