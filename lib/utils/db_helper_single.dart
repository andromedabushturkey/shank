import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:shank/controllers/create_new_db_controller.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class DBHelperSingle {
  DBHelperSingle._privateContructor();
  final CreateNewDbController _databaseController =
      Get.find<CreateNewDbController>();

  static final DBHelperSingle instance = DBHelperSingle._privateContructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      print('DB IS NOT NULL');
      return database;
    }
    print('INIT DB');
    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String _dbDirectory = directory.path + '/database';

    String path =
        join(_dbDirectory, _databaseController.databaseNameController.text);
    print('PATH: $path');

    await openDatabase(path + '.db', version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int ver) async {
    var _tableName = _databaseController.databaseNameController.text;
    print('TABLENAME: $_tableName');

    try {
      db.execute(
          '''CREATE TABLE ${_tableName + 'Daily'}(id INTEGER PRIMARY KEY, Date TEXT, Description TEXT, Deposit TEXT, Withdrawl TEXT, Notes TEXT )''');
      db.execute(
          '''CREATE TABLE ${_tableName + 'Credit'}(id INTEGER PRIMARY KEY, Date TEXT, Description TEXT, Deposit TEXT, Withdrawl TEXT, Notes TEXT )''');
      db.execute(
          '''CREATE TABLE ${_tableName + 'Recurring'}(id INTEGER PRIMARY KEY, Date TEXT, Description TEXT, Deposit TEXT, Withdrawl TEXT, Notes TEXT )''');
      db.execute(
          '''CREATE TABLE ${_tableName + 'Balance'}(id INTEGER PRIMARY KEY, Balance TEXT )''');
    } catch (e) {
      print('ERROR OPENING DB $e');
    }
    _databaseController.getExistingDB();
  }
}
