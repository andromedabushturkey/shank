import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class CreateNewDbController extends GetxController {
  @override
  void onInit() async {
    getExistingDB();
    super.onInit();
  }

  Database? _activeDB;
  var _listOfAvailDB = <FileSystemEntity>[].obs;
  RxBool _passwordOneObscureSet = true.obs;
  RxBool _passwordTwoObscureSet = true.obs;
  RxnString _dbNameErrorMsg = RxnString();
  RxnString _dbPasswordOneErrorMsg = RxnString();
  RxnString _dbPasswordTwoErrorMsg = RxnString();
  var _tableName = ''.obs;
  //TextEditingControllers for creating databasedf
  final TextEditingController databaseNameController = TextEditingController();
  final TextEditingController passwordOneController = TextEditingController();
  final TextEditingController passwordTwoController = TextEditingController();

  Database? get activeDB => this._activeDB;
  String? get dbNameError => this._dbNameErrorMsg.value;
  String? get dbPasswordOneErrorMsg => this._dbPasswordOneErrorMsg.value;
  String? get dbPasswordTwoErrorMsg => this._dbPasswordTwoErrorMsg.value;
  bool get passwordOneObscureSet => this._passwordOneObscureSet.value;
  bool get passwordTwoObscureSet => this._passwordTwoObscureSet.value;
  String get tableName => this._tableName.value;

  //getter that contains list of available databases
  List<FileSystemEntity> get listOfAvailDb => this._listOfAvailDB;

  set setActiveDB(value) => this._activeDB = value;
  set setPasswordOneObscure(value) => this._passwordOneObscureSet.value = value;
  set setPasswordTwoObscure(value) => this._passwordTwoObscureSet.value = value;

  set setDbNameError(value) => this._dbNameErrorMsg.value = value;

  set setDbPasswordOneErrorMsg(value) =>
      this._dbPasswordOneErrorMsg.value = value;

  set setDbpasswordTwoErrorMsg(value) =>
      this._dbPasswordTwoErrorMsg.value = value;
  set setListOfAvailDB(value) => this._listOfAvailDB.add(value);
  set removeDbOfAvailDB(value) => this._listOfAvailDB.removeAt(value);

  set tableName(value) => this._tableName.value = value;

  //Validate the DB creation form to make sure the info provided is complete
  bool validateNewDatabaseForm() {
    if (databaseNameController.text.isEmpty) {
      _dbNameErrorMsg.value = "Field can't be left empty";
      return false;
    }

    if (passwordOneController.text.isEmpty) {
      _dbPasswordOneErrorMsg.value = "Field can't be left empty";
      return false;
    }

    if (passwordTwoController.text.isEmpty) {
      _dbPasswordTwoErrorMsg.value = "Field can't be left empty";
      return false;
    }

    if (passwordOneController.text != passwordTwoController.text) {
      _dbPasswordOneErrorMsg.value = 'Passwords do not match';
      _dbPasswordTwoErrorMsg.value = 'Passwords do not match';
      return false;
    } else {
      _dbPasswordOneErrorMsg.value = '';
      _dbPasswordTwoErrorMsg.value = '';
    }
    return true;
  }

  void getExistingDB() async {
    Directory _dir = Directory("/data/user/0/com.example.shank/databases");
    if (await _dir.exists()) {
      var _dirContent = _dir.listSync();
      print('ITS THERE: $_dirContent');
      _listOfAvailDB.value = _dirContent;
    } else {
      print('directory is empty');
    }
  }

  Digest getDBDigest(int index) {
    var _bytes = utf8.encode(_listOfAvailDB[index].path);
    return md5.convert(_bytes);
  }

  String getDBLastModDdate(int index) {
    var _fileStats = _listOfAvailDB[index].statSync();
    DateTime _date = _fileStats.modified;
    return DateFormat.yMEd().add_jms().format(_date);
  }

  Future removeDbFromFileSystem(int index) async {
    print('INDEX: $index');
    print('file for deletion ${listOfAvailDb[index]}');
    try {
      _listOfAvailDB[index].deleteSync();
    } catch (e) {
      print('DELETE ERROR: $e');
    }
  }
}
