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

  late Database _activeDB;
  var _listOfAvailDB = <FileSystemEntity>[].obs;
  var _tableName = ''.obs;
  //TextEditingControllers for creating databasedf
  final TextEditingController databaseNameController = TextEditingController();
  final TextEditingController passwordOneController = TextEditingController();
  final TextEditingController passwordTwoController = TextEditingController();

  RxnString _openDBErrorMsg = RxnString();

  Database get activeDB => this._activeDB;
  String get tableName => this._tableName.value;

  String? get openDBErrorMsg => this._openDBErrorMsg.value;

  //getter that contains list of available databases
  List<FileSystemEntity> get listOfAvailDb => this._listOfAvailDB;

  set setActiveDB(value) => this._activeDB = value;
  set setListOfAvailDB(value) => this._listOfAvailDB.add(value);
  set removeDbOfAvailDB(value) => this._listOfAvailDB.removeAt(value);

  set tableName(value) => this._tableName.value = value;

  set setDBErrorMsg(value) => this._openDBErrorMsg.value = value;

  //Validate the DB creation form to make sure the info provided is complete

  void getExistingDB() async {
    String _dbDirectory = await getDatabasesPath() + '/database';
    Directory _dir = Directory(_dbDirectory);
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
