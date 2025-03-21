const { MercadoPagoConfig, Payment } = require('mercadopago');
require('dotenv').config();

// Configura o cliente do Mercado Pago
const client = new MercadoPagoConfig({
  accessToken: process.env.MP_TOKEN, // Substitua pelo seu ACCESS_TOKEN
});

const payments = new Payment(client);

function generateProductId(productName) {
  const nameHash = Buffer.from(productName).toString('base64').substring(0, 6);
  const random = Math.random().toString(36).substring(2, 6);
  return `${nameHash}-${random}`.toLowerCase(); // Ex: 'zxy123-abc'
}

const errorMap = {
  3034: {
    title: 'Cartão Inválido',
    actions: [
      'Verifique os dígitos do cartão',
      'Teste com cartão 4235 6478 9012 3456',
      'Gere novo token'
    ]
  },
  2001: {
    title: 'Pagamento Recusado',
    actions: [
      'Verifique limite do cartão',
      'Tente outro método de pagamento'
    ]
  },
  2010: {
    title: 'CPF Inválido',
    actions: [
      'Use formato 12345678900',
      'Teste com 12345678909'
    ]
  },
  2067: {
    title: 'CPF Inválido',
    actions: [
      'Use formato 12345678900',
      'Teste com 12345678909'
    ]
  },
  // Adicione outros códigos conforme necessário
};

// Função de tratamento
function handleMPError(error) {
  const errorCode = error.cause[0]?.code;
  const mappedError = errorMap[errorCode] || {
    title: 'Erro Desconhecido',
    actions: ['Contate o suporte técnico']
  };

  console.error(`ERRO ${errorCode}: ${mappedError.title}`);
  mappedError.actions.forEach((action, index) => {
    console.log(`${index + 1}. ${action}`);
  });

  return mappedError;
}

const errorMap2 = {
  'cc_rejected_bad_filled_security_code': {
    title: 'Código de segurança inválido',
  },
  'pending_contingency': {
    title: 'Pagamento pendente',
  },
  'cc_rejected_call_for_authorize': {
    title: 'Recusado com validação para autorizar',
  },
 'cc_rejected_insufficient_amount': {
    title: 'Limite insuficiente',
  },
  'cc_rejected_bad_filled_date': {
    title: 'Data de vencimento inválida',
  },
  'cc_rejected_duplicated_payment': {
    title: 'Existe uma compra similiar e o banco recusou a compra',
  },
};

function handleMPError2(error) {
  const mappedError = errorMap2[error] || {
    title: 'Erro Desconhecido',
    actions: ['Contate o suporte técnico']
  };
console.log(mappedError, error);
  return mappedError?.title ?? 'Erro desconhecido';
}

class MercadopagoController {

  static async createPreference(req, res) {
    try {
      const { transaction_amount, payment_method_id, payer, description } = req.body;

      const paymentData = {
        transaction_amount: transaction_amount,
        payment_method_id: payment_method_id,
        processing_mode: 'aggregator',
        description,
        payer: {
          email: payer.email,
          first_name: payer.first_name,
          last_name: payer.last_name,
          identification: {
            type: payer.identification.type,
            number: payer.identification.number,
          },
          address: {
            zip_code: payer.address.zip_code,
            city: payer.address.city,
            neighborhood: payer.address.neighborhood,
            street_name: payer.address.street_name,
            street_number: payer.address.street_number,
            federal_unit: payer.address.federal_unit,
          },
        }
      };


      const result = await payments.create({
        body: paymentData,
        requestOptions: { idempotencyKey: generateProductId(`${payer.email}${Date.now()}`) }, // Chave de idempotência
      });

      res.json(result);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }

  static async createCreditPay(req, res) {
    try {
      const { transaction_amount, token, description, installments, payer } = req.body;

      const paymentData = {
        transaction_amount,
        token,
        description,
        installments: installments?.installments ?? 1,
        payer
      };

      const result = await payments.create({
        body: paymentData,
        requestOptions: { idempotencyKey: generateProductId(`${payer.email}${Date.now()}`) }, // Chave de idempotência
      });

      if (result?.id && result?.status_detail && result?.status_detail !== 'accredited') {
        res.status(500).json({ error: handleMPError2(result?.status_detail) ?? 'Erro desconhecido' });
      } else {
        if (result?.status_detail && result?.status_detail === 'accredited') {
          res.status(200).json(result);
        }
      }

    } catch (error) {
      if (error?.id) {
        res.status(500).json({ error: handleMPError2(error?.status_detail) ?? 'Erro desconhecido' });
      } else {
        try {
          res.status(500).json({ error: handleMPError(error)?.title ?? 'Erro desconhecido' });
        } catch (er) {
          res.status(500).json({ error: 'Erro desconhecido' });
        }
      }
    }
  }
}

module.exports = MercadopagoController;