import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/db_helper_single.dart';

class AccountBalanceController extends GetxController {
  @override
  void onReady() async {
    await getBalance();
    super.onReady();
  }

  final TextEditingController accountBalanceEditor = TextEditingController();
  var _accountBalance = '0'.obs;

  get accountBalance => this._accountBalance;

  set setAccountBalance(value) => this._accountBalance.value = value;

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
      _accountBalance.value = _initialAccountBalance;

      update();
    }
  }
}
