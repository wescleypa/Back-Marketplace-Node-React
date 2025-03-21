// src/services/searchService.js
const Scraper = require('../utils/scraper');

class SearchService {
  static async searchMercadoLivre(query, length=null) {
    var url = `https://lista.mercadolivre.com.br/${query}`;
    if (length && length > 1) {
      url = `https://lista.mercadolivre.com.br/${query+`_Desde_${((length-1) * 50) - 1}_NoIndex_True`}`;
    }
    console.log(url);
    const selector = '.ui-search-layout__item';
    
    return await Scraper.scrape(url, selector, length);
  }
}

module.exports = SearchService;