import 'package:get/get.dart';

class AccountBalanceController extends GetxController {
  var _accountBalance = 0.obs;

  get accountBalance => this._accountBalance.value;
}
