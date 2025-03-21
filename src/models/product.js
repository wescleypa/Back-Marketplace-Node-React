const { chromium } = require('playwright');
const pool = require('../config/db');

class Product {
  /**
   * Realiza o scraping das informações detalhadas do produto a partir do link.
   * @param {string} productLink - Link do produto no Mercado Livre.
   * @returns {Promise<Object>} - Objeto com as informações detalhadas do produto.
   */
  static async find(productLink) {
    const browser = await chromium.launch({ headless: true }); // headless: true para rodar em segundo plano
    const page = await browser.newPage();
    await page.goto(productLink);

    // Aguarda o carregamento da página
    await page.waitForSelector('.ui-pdp-title'); // Aguarda o título do produto

    // Extrai as informações do produto
    const productDetails = await page.evaluate(() => {
      // Função para extrair o texto de um elemento ou retornar um valor padrão
      const getText = (selector, defaultValue = 'Não disponível', element = null) => {
        var el = null;

        if (element) {
          el = element.querySelector(selector);
        } else {
          el = document.querySelector(selector);
        }
        return el ? el.innerText.trim() : defaultValue;
      };

      // Função para extrair o atributo src de uma imagem ou retornar um valor padrão
      const getImageSrc = (selector, defaultValue = 'https://www.malhariapradense.com.br/wp-content/uploads/2017/08/produto-sem-imagem.png') => {
        const element = document.querySelector(selector);
        return element ? element.src : defaultValue;
      };

      // Extrai as informações básicas
      const condition = getText('.ui-pdp-subtitle');
      const rating = parseFloat(getText('.ui-pdp-reviews__rating__summary .ui-pdp-reviews__rating__number'));
      const reviewsCount = parseInt(getText('.ui-pdp-reviews__rating__summary .ui-pdp-reviews__rating__label'), 10);
      const aval = getText('.ui-review-capability__rating__average.ui-review-capability__rating__average--desktop');
      const avals = getText('.ui-review-capability__rating__label');
      const description = getText('.ui-pdp-description__content', 'Sem descrição.');
      const memory = Array.from(document.querySelectorAll('.ui-pdp-thumbnail__label')).map(item => item?.innerText);

      // Extrai as imagens do produto
      const images = Array.from(document.querySelectorAll('.ui-pdp-gallery__figure img')).map(img => img.src);

      // Extrai as cores disponíveis (se houver)
      const colors = Array.from(document.querySelectorAll('.ui-pdp-thumbnail__picture.ui-pdp-thumbnail__picture--LARGE > img')).map(color => color.getAttribute('alt'));

      // Extrai as avaliações (reviews)
      const reviews = Array.from(document.querySelectorAll('.ui-review-capability-comments__comment')).map(review => {
        review.scrollIntoView({ behavior: 'smooth', block: 'center' });

        const stars = document.querySelectorAll('.ui-review-capability-comments__comment__rating')?.length;
        var comment = getText('.ui-review-capability-comments__comment__content.ui-review-capability-comments__comment__content', 'Sem comentário', review);
        comment = comment.toString().toLowerCase().replace('mercadolivre', 'site');
        comment = comment.toString().toLowerCase().replace('mercado livre', 'site');
        comment = comment.toString().toLowerCase().replace('mercado libre', 'site');
        comment = comment.toString().toLowerCase().replace('mercado pago', 'site');
        comment = comment.toString().toLowerCase().replace('mercadopago', 'site');
        const date = getText('.ui-review-capability-comments__comment__date', 'Data não disponível', review);

        const photos = [];
        const imgs = review.querySelectorAll('.ui-review-capability-carousel__img');

        imgs.forEach((img) => {
          const src = img.getAttribute('data-src') || img.getAttribute('src');
          if (src && !src.includes('base64')) {
            photos.push(src);
          }
        });

        return {
          stars,
          comment,
          date,
          photos
        };
      });

      return {
        condition,
        rating,
        reviewsCount,
        images,
        colors,
        memory,
        reviews,
        aval,
        avals,
        description
      };
    });

    await browser.close();
    return productDetails;
  }

  static async addToCart(data) {
    const { userId, product } = data;
    const { title, price, image, rating, link, id, discount, originalPrice } = product;
    
    const [result] = await pool.execute(
      `INSERT INTO user_cart (title, price, image, rating, link, product, discount, originalPrice, user)
      VALUES
      (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [title, price, image, rating, link, id, discount, originalPrice, userId]
    );

    return result;
  }
}

module.exports = Product;