import 'package:flutter/widgets.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

class DailyFinanceController extends GetxController {
  MoneyMaskedTextController expenseTextController =
      MoneyMaskedTextController(decimalSeparator: '.', initialValue: 0.00);

  TextEditingController expenseDescriptionController = TextEditingController();
  TextEditingController expenseNotesController = TextEditingController();
  TextEditingController expenseDateController =
      TextEditingController(text: 'test');

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}
