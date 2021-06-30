import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shank/utils/db_helper_single.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

import 'create_new_db_controller.dart';

class AccountBalanceController extends GetxController {
  CreateNewDbController _dbController =
      Get.put<CreateNewDbController>(CreateNewDbController());

  @override
  void onReady() async {
    await getBalance();
    super.onReady();
  }

  final TextEditingController accountBalanceEditor = TextEditingController();
  var _accountBalance = '0'.obs;

  get accountBalance => this._accountBalance;

  set accountBalance(value) => this._accountBalance.value = value;

  //Get and insert current balance in titlebar
  Future getBalance() async {
    String _tableName = _dbController.tableName + 'Balance';
    var _db = await DBHelperSingle.instance.database;

    if (_db != null) {
      List<Map<String, dynamic>> _getBalance =
          await _db.query(_tableName, where: 'id =1');
      String _initialAccountBalance = _getBalance[0]['Balance'];
    }
  }
}
