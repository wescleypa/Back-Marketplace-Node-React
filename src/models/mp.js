class MP {
  static async verifyWebhook(signature, body) {
    const publicKey = process.env.MP_PUBLIC_KEY;
    const verifier = crypto.createVerify('RSA-SHA256');

    verifier.update(JSON.stringify(body));
    return verifier.verify(publicKey, signature, 'base64');
  }

  static async handlePaymentNotification(payment) {
    console.log('Novo pagamento:', payment.id, payment.status);

    switch (payment.status) {
      case 'approved':
        await confirmPayment(payment);
        break;
      case 'pending':
        await handlePendingPayment(payment);
        break;
      case 'cancelled':
        await handleCancelledPayment(payment);
        break;
      default:
        console.warn('Status desconhecido:', payment.status);
    }
  }
}

module.exports = MP;