const Product = require('../models/Product');

class ProductService {
  static async getAllProducts() {
    return await Product.findAll();
  }

  static async getProduct(product) {
    return await Product.find(product?.link ?? null);
  }

  static async createProduct(productData) {
    return await Product.create(productData);
  }

  static async addToCart(data) {
    return await Product.addToCart(data);
  }
}

module.exports = ProductService;