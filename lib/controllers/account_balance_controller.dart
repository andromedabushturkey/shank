import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shank/controllers/create_new_db_controller.dart';
import 'package:shank/screens/create_database.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class AccountBalanceController extends GetxController {
  CreateNewDbController _dbController =
      Get.put<CreateNewDbController>(CreateNewDbController());

  final TextEditingController accountBalanceEditor = TextEditingController();

  var _accountBalance = 0.obs;

  get accountBalance => () async {
        var testBalance = await getBalance();
        print('TESTBALA: $testBalance');
      };

  Future<double> getBalance() async {
    String _tableName = _dbController.tableName + 'Balance';
    Database _db = _dbController.activeDB;
    var testGet = await _db.query(_tableName, where: 'id =1');
    var myvalue = testGet[0]['Balance'];
    return myvalue;

    // _db.update(_tableName, values)
  }

  double newBalanceToDouble(String newBalanceValue) {
    return double.parse(newBalanceValue);
  }
}
