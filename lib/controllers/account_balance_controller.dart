import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:money2/money2.dart';

import '../utils/db_helper_single.dart';

class AccountBalanceController extends GetxController {
  @override
  void onReady() async {
    initCurrencies();
    await getBalance();
    super.onReady();
  }

  final TextEditingController accountBalanceEditor =
      MoneyMaskedTextController(initialValue: 0.00, decimalSeparator: '.');
  RxString _accountBalance = RxString('0');

  get accountBalance => this._accountBalance;

  set setAccountBalance(value) {
    var _cadCurrency = Currencies.find('CAD');
    if (_cadCurrency != null) {
      var _money = _cadCurrency.parse(value);
      _accountBalance.value = _money.toString();
    }
  }

  //Get and insert current balance in titlebar
  Future getBalance() async {
    final _box = GetStorage();
    String _tableName = _box.read('databaseName');

    String _fullDBName = _tableName + 'Balance';
    var _db = await DBHelperSingle.instance.database;

    List<Map<String, dynamic>> _getBalance =
        await _db.query(_fullDBName, where: 'id =1');

    if (_getBalance.length > 0) {
      String _initialAccountBalance = _getBalance[0]['Balance'];
      Currency? _cadCurrency = Currencies.find('CAD');
      if (_cadCurrency != null) {
        print('initial account balance:' + '\$CAD' + '$_initialAccountBalance');
        print(r'$USD1500.0');
        print(_cadCurrency.code);
        _accountBalance.value =
            (_cadCurrency.parse('\$' + '$_initialAccountBalance')).toString();
      }

      update();
    }
  }

  initCurrencies() {
    Currency _cad = Currency.create('CAD', 2);
    Currencies.register(_cad);
  }
}
