import 'package:get/get.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

import '../controllers/create_new_db_controller.dart';

class DBHelper {
  static Database _activeDB;
  static final _version = 1;

  static Future<void> initDB() async {
    //get access to the controller
    CreateNewDbController _controller = Get.find<CreateNewDbController>();

    //get and create path for db
    String _path = await getDatabasesPath() + '/' + _controller.databaseNameController.text + '.db';

    //get access to user password
    String _password = _controller.passwordOneController.text;

    //get access to dbName/tableName
    String _tableName = _controller.databaseNameController.text;

    try {
      print('TABLENAME: $_tableName');
      _activeDB = await openDatabase(
        _path,
        version: _version,
        password: _password,
        onCreate: (db, version) {
          db.execute("CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, title STRING, note TEXT)");
        },
      );
      _controller.getExistingDB();
      //assign active db to controller variable
      await _activeDB.close();
      var status = _activeDB.isOpen;
      print('DBSTATUS: $status');
    } catch (e) {
      Get.snackbar('Error', 'Unable to create database');
    }
  }

  static Future<void> openDB(String dbName) async {
    print('databae name $dbName');
    CreateNewDbController _controller = Get.find<CreateNewDbController>();

    //get and create path for db
    String _path = await getDatabasesPath() + '/' + dbName;
    print('path: $_path');

    //get access to user password
    String _password = _controller.passwordOneController.text;
    print('password: $_password');

    if (_activeDB != null) {
      return;
    }

    try {
      print('openDB');
      _activeDB = await openDatabase(_path, password: _password, version: 1);
      print('dbopen: ${_activeDB.isOpen}');
      //     _controller.setActiveDatabase = _activeDB;
      var _tableName = dbName.replaceAll('.db', '');
      print('tableName: $_tableName');

      var myValue = {'title': 'my made up title'};
      _activeDB.insert(_tableName, myValue);
      // _controller.database.insert(_tableName, myValue);

      // _activeDB.insert(_tableName, myValue);
    } catch (e) {
      print(e);
    }
  }
}
