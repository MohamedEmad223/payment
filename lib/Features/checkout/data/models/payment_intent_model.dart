class PaymentIntentModel {
  final String amount;
  final String currency;

  PaymentIntentModel({
    required this.amount,
    required this.currency,
  });

  tojson() {
    return {
      'amount': amount,
      'currency': currency,
    };
  }

}
