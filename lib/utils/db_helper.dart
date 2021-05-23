import 'package:get/get.dart';
import 'package:shank/models/account_balance.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

import '../controllers/create_new_db_controller.dart';

class DBHelper {
  //static Database _activeDB;
  static final _version = 1;

  static Future<void> initDB() async {
    //get access to the controller
    CreateNewDbController _controller = Get.find<CreateNewDbController>();

    //get and create path for db
    String _path = await getDatabasesPath() +
        '/' +
        _controller.databaseNameController.text +
        '.db';

    //get access to user password
    String _password = _controller.passwordOneController.text;

    //get access to dbName/tableName
    String _tableName = _controller.databaseNameController.text;

    try {
      print('TABLENAME: $_tableName');
      _controller.setActiveDB = await openDatabase(
        _path,
        version: _version,
        password: _password,
        onCreate: (db, version) {
          db.execute(
              '''CREATE TABLE ${_tableName + 'Daily'}(id INTEGER PRIMARY KEY, Date INT, Description TEXT, Deposit NUM, Withdrawl NUM, Notes TEXT )''');
          db.execute(
              '''CREATE TABLE ${_tableName + 'Credit'}(id INTEGER PRIMARY KEY, Date INT, Description TEXT, Deposit NUM, Withdrawl NUM, Notes TEXT, Balance NUM )''');
          db.execute(
              '''CREATE TABLE ${_tableName + 'Recurring'}(id INTEGER PRIMARY KEY, Date INT, Description TEXT, Deposit NUM, Withdrawl NUM, Notes TEXT )''');
          db.execute(
              '''CREATE TABLE ${_tableName + 'Balance'}(id INTEGER PRIMARY KEY, Balance NUM )''');
        },
      );
      _controller.getExistingDB();
      await _controller.activeDB.close();
      // await _activeDB.close();
    } catch (e) {
      Get.snackbar('Error', 'Unable to create database');
    }
  }

  static Future<void> openDB(String dbName) async {
    print('databae name $dbName');
    CreateNewDbController _controller = Get.find<CreateNewDbController>();

    //get and create path for db
    String _path = await getDatabasesPath() + '/' + dbName;

    //get access to user password
    String _password = _controller.passwordOneController.text;

    try {
      print('openDB');
      _controller.setActiveDB =
          await openDatabase(_path, password: _password, version: 1);
      var _tableName = dbName.replaceAll('.db', '');
      _controller.tableName = _tableName;
    } catch (e) {
      print(e);
    }
  }

  Future<int> insertBalance(AccountBalance acctB) async {
    var _dbController = Get.find<CreateNewDbController>();
    var _tableN = _dbController.tableName + 'Balance';
    var result = await _dbController.activeDB.insert('$_tableN', acctB.toMap());
    print('THIS IS THE TEST MAP: $result');
    return result;
  }
}
