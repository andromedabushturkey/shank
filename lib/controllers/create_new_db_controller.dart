import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
    String _dbDirectory = await getDatabasesPath();
    Directory _dir = Directory(_dbDirectory);
    if (await _dir.exists()) {
      var _dirContent = _dir.listSync();

      print('ITS THERE: $_dirContent');
      _listOfAvailDB.value = _dirContent;
    } else {
      print('directory is empty');
    }
  }

  Future<String> dbFullPath() async {
    var _box = GetStorage();

    String _dbName = _box.read('databaseName');
    String _dbStorage = await getDatabasesPath();
    return _dbStorage + '/' + _dbName + '.db';
  }

  Future<Digest> getDBDigest() async {
    String _db = await dbFullPath();
    print('FULL PATH: $_db');
    var _bytes = utf8.encode(_db);
    return md5.convert(_bytes);
  }

  Future<String> getDBLastModDdate() async {
    String _db = await dbFullPath();

    var _fileStats = _listOfAvailDB[0].statSync();
    DateTime _date = _fileStats.modified;
    return DateFormat.yMEd().add_jms().format(_date);
  }

  Future removeDbFromFileSystem() async {
    print('file for deletion ${listOfAvailDb[0]}');
    try {
      _listOfAvailDB[0].deleteSync();
    } catch (e) {
      print('DELETE ERROR: $e');
    }
  }

  String getDatabaseName() {
    var _box = GetStorage();
    String? _databaseName = _box.read('databaseName');
    if (_databaseName != null) {
      return _box.read('databaseName');
    } else {
      return '';
    }
  }
}
