import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
//  Rx<Database> _activeDatabase = Rx<Database>(null);
  var _databaseList = <String>[].obs;
  RxList<DateTime> _dateModified = RxList([]);

  //TextEditingControllers for creating databasedf
  final TextEditingController databaseNameController = TextEditingController();
  final TextEditingController passwordOneController = TextEditingController();
  final TextEditingController passwordTwoController = TextEditingController();
  List<FileSystemEntity> get listOfAvailDb => this._listOfAvailDB.value;
  String get dbNameError => this._dbNameErrorMsg.value;
  String get dbPasswordOneErrorMsg => this._dbPasswordOneErrorMsg.value;
  String get dbPasswordTwoErrorMsg => this._dbPasswordTwoErrorMsg.value;
  // Database get database => this._activeDatabase.value;
  bool get passwordOneObscureSet => this._passwordOneObscureSet.value;
  bool get passwordTwoObscureSet => this._passwordTwoObscureSet.value;
  List<String> get databaseList => this._databaseList;
  List<DateTime> get dateModified => this._dateModified.value;
  //set setActiveDatabase(value) => this._activeDatabase.value = value;

  set setPasswordOneObscure(value) => this._passwordOneObscureSet.value = value;
  set setPasswordTwoObscure(value) => this._passwordTwoObscureSet.value = value;

  set setDatabaseList(value) => this._databaseList.add(value);
  set setDateModified(value) => this._dateModified.add(value);

  set setDbNameError(value) => this._dbNameErrorMsg.value = value;

  set setDbPasswordOneErrorMsg(value) => this._dbPasswordOneErrorMsg.value = value;

  set setDbpasswordTwoErrorMsg(value) => this._dbPasswordTwoErrorMsg.value = value;
  set setListOfAvailDB(value) => this._listOfAvailDB.add(value);
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
      for (var item in _dirContent) {
        setListOfAvailDB = item;
      }
      print(_databaseList);
    } else {
      print('directory is empty');
    }
  }

  void addDatabaseToList() async {
    print('what I think: ${databaseNameController.text}');
    setDatabaseList = databaseNameController.text;
    databaseNameController.clear();
    print('NEWDb: $_databaseList');
  }

  buildDatabaseList() {
    Directory _dir = Directory("/data/user/0/com.example.shank/databases");
    if (_dir.existsSync()) {
      setListOfAvailDB = _dir.listSync();
      print('NewTESTLIST: ${_listOfAvailDB.value}');
      return _dir.listSync();
    } else {
      Directory("/data/user/0/com.example.shank/databases").createSync(recursive: true);
      Directory _dir = Directory("/data/user/0/com.example/shank/databases");
      return _dir.listSync();
    }
  }

  void deleteDatabase(int index) async {
    Directory _dir = Directory("/data/user/0/com.example.shank/databases");
    List<FileSystemEntity> _directoryContent = _dir.listSync();
    await _directoryContent[index].delete();
  }
}
