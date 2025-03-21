const { chromium } = require('playwright');
const logger = require('./logger');

class Scraper {
  static async scrape(url, selector) {
    const browser = await chromium.launch({ headless: true });
    const page = await browser.newPage();
    await page.goto(url);

    // Aguarda o carregamento inicial dos produtos
    await page.waitForSelector(selector);

    // Rola a página para baixo para carregar mais itens (lazy loading)
    await autoScroll(page);

    // Extrai o número total de páginas
    const totalPages = await page.evaluate(() => {
      const paginationItems = document.querySelectorAll('.andes-pagination__link'); // Seletor da paginação
      if (paginationItems.length === 0) return 1; // Se não houver paginação, assume-se que há apenas 1 página

      // Obtém o número da última página
      const lastPageItem = paginationItems[paginationItems.length - 1];
      const lastPageText = lastPageItem.innerText.trim();

      // Verifica se o texto é um número
      if (!isNaN(lastPageText)) {
        return parseInt(lastPageText, 10);
      } else {
        // Se não for um número (por exemplo, "Próxima"), retorna o número de itens menos 1
        return paginationItems.length - 1;
      }
    });

    logger.info(`Total de páginas encontradas: ${totalPages}`);

    // Extrai os dados dos produtos
    const data = await page.evaluate((selector) => {
      const extractData = (item) => {
        const titleElement = item.querySelector('.poly-component__title');
        const priceElement = item.querySelector('.andes-money-amount__fraction');
        const imageElement = item.querySelector('.poly-component__picture');
        const rateElement = item.querySelector('.poly-reviews__rating');
        const reviewsElement = item.querySelector('.poly-reviews__total');
        const linkElement = item.querySelector('.poly-component__title');

        return {
          title: titleElement ? titleElement.innerText : 'Título não disponível',
          price: priceElement ? priceElement.innerText : 'Preço não disponível',
          image: imageElement ? imageElement.getAttribute('src') : 'https://www.malhariapradense.com.br/wp-content/uploads/2017/08/produto-sem-imagem.png',
          rating: rateElement ? rateElement.innerText : 4.5,
          reviews: reviewsElement ? reviewsElement.innerText : 0,
          link: linkElement ? linkElement.getAttribute('href') : null,
          id: linkElement ? linkElement.getAttribute('href')?.toString().split('/p/')[1].split('#polycard')[0] : null
        };
      };

      const items = [];
      const elements = document.querySelectorAll(selector);

      elements.forEach((item) => {
        try {
          const data = extractData(item);
          items.push(data);
        } catch (error) {
          console.error('Erro ao processar item:', error);
        }
      });

      return items;
    }, selector);

    await browser.close();
    logger.info(`Scraped ${data.length} items from ${url}`);
    return { data, totalPages };
  }
}

// Função para rolar a página automaticamente
async function autoScroll(page) {
  await page.evaluate(async () => {
    await new Promise((resolve) => {
      let totalHeight = 0;
      const distance = 1000; // Quantidade de pixels a rolar por vez
      const timer = setInterval(() => {
        const scrollHeight = document.body.scrollHeight;
        window.scrollBy(0, distance);
        totalHeight += distance;

        // Para de rolar quando chegar ao final da página
        if (totalHeight >= scrollHeight) {
          clearInterval(timer);
          resolve();
        }
      }, 100); // Intervalo de rolagem
    });
  });
}

module.exports = Scraper;