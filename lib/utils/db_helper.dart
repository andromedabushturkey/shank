import 'package:get/get.dart';
import 'package:shank/controllers/create_new_db_controller.dart';
import 'package:shank/screens/create_database.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class DBHelper {
  CreateNewDbController _createDatabaseController =
      Get.find<CreateNewDbController>();
  static Database _db;
  static final _version = 1;

  static Future<void> initDB() async {
    //get access to the controller
    CreateNewDbController _controller = Get.find<CreateNewDbController>();
    //get and create path for db
    String _path = await getDatabasesPath() +
        '/' +
        _controller.databaseNameController.text +
        '.db';
    print('DBACTUAL: $_path');
    //get access to user password
    String _password = _controller.passwordOneController.text;

    //get access to dbName/tableName
    String _tableName = _controller.databaseNameController.text;

    if (_db != null) {
      return;
    }
    try {
      _db = await openDatabase(_path, version: _version, password: _password,
          onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, title STRING, note TEXT)");
      });
    } catch (e) {
      print(e);
    }
  }
}
