const { MercadoPagoConfig, Payment } = require('mercadopago');
const { MP } = require('../models/mp');
require('dotenv').config();

const client = new MercadoPagoConfig({
  accessToken: process.env.MP_TOKEN, // Substitua pelo seu ACCESS_TOKEN
});

const payments = new Payment(client);

class MercadopagoService {

  static async webhook(req, res) {
    try {
      const { id, action } = req.body;

      // Buscar detalhes do pagamento
      console.log(id)
      const payment = await payments.get(id);
   
      // Processar notificação
      //await MP.handlePaymentNotification(payment.body);

      res.status(200).end();
    } catch (error) {
      console.error('Webhook error:', error);
      res.status(500).send();
    }
  }
}

module.exports = MercadopagoService;