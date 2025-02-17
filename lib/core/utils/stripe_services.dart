import 'package:checkout_payment_ui/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/models/payment_intent_model/payment_intent_model.dart';
import 'package:checkout_payment_ui/core/utils/api_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StripeServices {
  final ApiServices _apiServices;
  final PaymentIntentInputModel _paymentIntentInputModel;
  StripeServices(this._apiServices, this._paymentIntentInputModel);
  createPaymentIntent(PaymentIntentInputModel paymentIntentInputModel) async {
    var respone = await _apiServices.post(
        url: 'https://api.stripe.com/v1/payment_intents',
        body: _paymentIntentInputModel.tojson(),
        token: dotenv.env['.env']);
    var paymentIntentModel = PaymentIntentModel.fromJson(respone.data);
    return paymentIntentModel;
  }
}
