import 'package:get/get.dart';
import 'package:money2/money2.dart';

class HomepageController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print('Starting Homepage Controller init');
    Currency _cad = Currency.create('CAD', 2);
    Currencies.register(_cad);
  }
}
