import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shank/models/account_balance.dart';
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

  Future getBalance() async {
    String _tableName = _dbController.tableName + 'Balance';
    Database? _db = _dbController.activeDB;
    List<Map<String, dynamic>>? testGet =
        await _db?.query(_tableName, where: 'id =1');
    String myvalue = testGet?[0]['Balance'];

    accountBalance = myvalue.toString();

    // _db.update(_tableName, values)
  }

  double newBalanceToDouble(String newBalanceValue) {
    double myNewBalance = double.parse(newBalanceValue);
    accountBalance = myNewBalance.toString();
    return myNewBalance;
  }
}
