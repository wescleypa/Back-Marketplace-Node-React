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
    const data = await page.evaluate((params) => {
      const extractData = (item) => {

        const isNoIndex = params.url.includes('NoIndex_True');
        const titleElement = item.querySelector(
          isNoIndex
            ? '.ui-search-link__title-card.ui-search-link'
            : '.poly-component__title'
        );

        const imageElement = item.querySelector(
          isNoIndex
            ? '.ui-search-result-image__element'
            : '.poly-component__picture'
        );

        const rateElement = item.querySelector(
          isNoIndex
            ? '.ui-search-reviews__rating-number'
            : '.poly-reviews__rating'
        );

        const reviewsElement = item.querySelector(
          isNoIndex
            ? '.ui-search-reviews__amount'
            : '.poly-reviews__total'
        );

        const linkElement = item.querySelector(
          isNoIndex
            ? '.ui-search-link__title-card.ui-search-link'
            : '.poly-component__title'
        );

        function extrairCodigoMLB(url) {
          try {
            const partes = url.split('/');
            if (partes.length < 5) throw new Error('URL inválida');

            const segmento = partes[4];
            const [prefixo, numero] = segmento.split('-');

            if (!prefixo || !numero) throw new Error('Padrão não encontrado');

            return {
              comTraco: `${prefixo}-${numero.split('-')[0]}`,
              semTraco: `${prefixo}${numero.split('-')[0]}`
            };
          } catch (error) {
            console.error('Erro ao extrair código:', error);
            return { comTraco: null, semTraco: null };
          }
        }

        const idElement =
          isNoIndex
            ? extrairCodigoMLB(linkElement)
            : (
              linkElement
                ? linkElement.getAttribute('href')?.toString().split('/p/')[1].split('#polycard')[0]
                : null
            );

        const priceElement = item.querySelector('.andes-money-amount__fraction');

        return {
          title: titleElement ? titleElement.innerText : 'Título não disponível',
          price: priceElement ? priceElement.innerText : 'Preço não disponível',
          image: imageElement ? imageElement.getAttribute('src') : 'https://www.malhariapradense.com.br/wp-content/uploads/2017/08/produto-sem-imagem.png',
          rating: rateElement ? rateElement.innerText : 4.5,
          reviews: reviewsElement ? reviewsElement.innerText : 0,
          link: linkElement ? linkElement.getAttribute('href') : null,
          id: idElement ?? null
        };
      };

      const items = [];
      const elements = document.querySelectorAll(params.selector);

      elements.forEach((item) => {
        try {
          const data = extractData(item);
          items.push(data);
        } catch (error) {
          console.error('Erro ao processar item:', error);
        }
      });

      return items;
    }, { selector, url });

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