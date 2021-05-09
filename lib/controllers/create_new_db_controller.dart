import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateNewDbController extends GetxController {
  @override
  void onInit() async {
    getExistingDB();
    super.onInit();
  }

  var _listOfAvailDB = <FileSystemEntity>[].obs;
  RxBool _passwordOneObscureSet = true.obs;
  RxBool _passwordTwoObscureSet = true.obs;
  RxString _dbNameErrorMsg = RxString(null);
  RxString _dbPasswordOneErrorMsg = RxString(null);
  RxString _dbPasswordTwoErrorMsg = RxString(null);
  RxList<DateTime> _dateModified = RxList([]);

  //TextEditingControllers for creating databasedf
  final TextEditingController databaseNameController = TextEditingController();
  final TextEditingController passwordOneController = TextEditingController();
  final TextEditingController passwordTwoController = TextEditingController();

  String get dbNameError => this._dbNameErrorMsg.value;
  String get dbPasswordOneErrorMsg => this._dbPasswordOneErrorMsg.value;
  String get dbPasswordTwoErrorMsg => this._dbPasswordTwoErrorMsg.value;
  bool get passwordOneObscureSet => this._passwordOneObscureSet.value;
  bool get passwordTwoObscureSet => this._passwordTwoObscureSet.value;

  //getter that contains list of available databases
  List<FileSystemEntity> get listOfAvailDb => this._listOfAvailDB;

  List<DateTime> get dateModified => this._dateModified.value;

  set setPasswordOneObscure(value) => this._passwordOneObscureSet.value = value;
  set setPasswordTwoObscure(value) => this._passwordTwoObscureSet.value = value;

  set setDateModified(value) => this._dateModified.add(value);

  set setDbNameError(value) => this._dbNameErrorMsg.value = value;

  set setDbPasswordOneErrorMsg(value) => this._dbPasswordOneErrorMsg.value = value;

  set setDbpasswordTwoErrorMsg(value) => this._dbPasswordTwoErrorMsg.value = value;
  set setListOfAvailDB(value) => this._listOfAvailDB.add(value);
  set removeDbOfAvailDB(value) => this._listOfAvailDB.removeAt(value);
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
}
