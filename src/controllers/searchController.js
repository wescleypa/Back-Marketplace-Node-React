// src/controllers/searchController.js
const SearchService = require('../services/searchService');

class SearchController {
  static async search(req, res) {
    try {
      const query = req.query.q;
      const products = await SearchService.searchMercadoLivre(query);
      res.json(products);
    } catch (error) {
      console.error(error)
      res.status(500).json({ error: error.message });
    }
  }
}

module.exports = SearchController;