import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class CreateNewDbController extends GetxController {
  @override
  void onInit() async {
    var _path = await getDatabasesPath();
    // String vv = _path.path;
    print('PATH: $_path');
    Directory _dir = Directory("/data/user/0/com.example.shank/databases");
    var content = _dir.listSync();
    print('DIRECTORY: $content');
    super.onInit();
  }

  RxBool _passwordOneObscureSet = true.obs;
  RxBool _passwordTwoObscureSet = true.obs;
  RxString _dbNameErrorMsg = RxString(null);
  RxString _dbPasswordOneErrorMsg = RxString(null);
  RxString _dbPasswordTwoErrorMsg = RxString(null);
  Rx<Database> _database = Rx<Database>(null);

  //TextEditingControllers for creating databasedf
  final TextEditingController databaseNameController = TextEditingController();
  final TextEditingController passwordOneController = TextEditingController();
  final TextEditingController passwordTwoController = TextEditingController();

  String get dbNameError => this._dbNameErrorMsg.value;
  String get dbPasswordOneErrorMsg => this._dbPasswordOneErrorMsg.value;
  String get dbPasswordTwoErrorMsg => this._dbPasswordTwoErrorMsg.value;
  Database get database => this._database.value;
  bool get passwordOneObscureSet => this._passwordOneObscureSet.value;
  bool get passwordTwoObscureSet => this._passwordTwoObscureSet.value;

  set setPasswordOneObscure(value) => this._passwordOneObscureSet.value = value;
  set setPasswordTwoObscure(value) => this._passwordTwoObscureSet.value = value;

  set setDbNameError(value) => this._dbNameErrorMsg.value = value;

  set setDbPasswordOneErrorMsg(value) =>
      this._dbPasswordOneErrorMsg.value = value;

  set setDbpasswordTwoErrorMsg(value) =>
      this._dbPasswordTwoErrorMsg.value = value;

//Validate the DB creation form to make sure the info provided is complete
  bool validateNewDatabaseForm() {
    if (databaseNameController.text.isEmpty) {
      _dbNameErrorMsg.value = "Field can't be left empty";
      return false;
    } else {
      _dbNameErrorMsg.value = null;
    }
    if (passwordOneController.text != passwordTwoController.text) {
      _dbPasswordOneErrorMsg.value = 'Passwords do not match';
      _dbPasswordTwoErrorMsg.value = 'Passwords do not match';
      return false;
    } else {
      _dbPasswordOneErrorMsg.value = null;
      _dbPasswordTwoErrorMsg.value = null;
    }
    return true;
  }

//create and open new database
  void createNewDatabase({String dbName, String dbPassword}) async {
    // if (_database != null) {
    //   return;
    // }
    var _directory = await getApplicationDocumentsDirectory();
    var _path = _directory.path + '/$dbName.db';
    print('PATH: $_path');

    _database.value = await openDatabase(_path,
        password: dbPassword, version: 1, onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE $dbName(id INTEGER PRIMARY KEY, title STRING, note TEXT)");
    });
  }
}
