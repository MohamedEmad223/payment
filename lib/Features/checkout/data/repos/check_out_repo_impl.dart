import 'package:checkout_payment_ui/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/repos/check_out_repo.dart';
import 'package:checkout_payment_ui/core/error/faluire.dart';
import 'package:checkout_payment_ui/core/utils/stripe_services.dart';
import 'package:dartz/dartz.dart';

class CheckOutRepoImpl extends CheckOutRepo{
  final StripeServices _stripeServices;
  CheckOutRepoImpl(this._stripeServices);
  @override
  Future<Either<Failure, void>> makePayment ({required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      await _stripeServices.makePayment(paymentIntentInputModel: paymentIntentInputModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}