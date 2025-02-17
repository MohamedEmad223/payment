import 'package:checkout_payment_ui/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/models/payment_intent_model/payment_intent_model.dart';
import 'package:checkout_payment_ui/core/utils/api_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeServices {
  final ApiServices _apiServices;
  final PaymentIntentInputModel _paymentIntentInputModel;
  StripeServices(this._apiServices, this._paymentIntentInputModel);
  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    var respone = await _apiServices.post(
        url: dotenv.env['STRIPE_PAYMENT_INTENT_URL']!,
        body: _paymentIntentInputModel.tojson(),
        token: dotenv.env['SECRET_KEY']!);
    var paymentIntentModel = PaymentIntentModel.fromJson(respone.data);
    return paymentIntentModel;
  }

  Future initPaymentSheet({required String paymentIntentClintSecret}) async {
    Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: paymentIntentClintSecret,
      merchantDisplayName: 'Flutter Stripe Store',
    ));
  }

  Future presentPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    await initPaymentSheet(
        paymentIntentClintSecret: paymentIntentModel.clientSecret!);
    await presentPaymentSheet();
  }
}
