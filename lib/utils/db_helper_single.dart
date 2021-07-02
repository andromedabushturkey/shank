import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

import '../controllers/create_new_db_controller.dart';

class DBHelperSingle {
  DBHelperSingle._privateContructor();

  final CreateNewDbController _databaseController =
      Get.find<CreateNewDbController>();

  static final DBHelperSingle instance = DBHelperSingle._privateContructor();

  static Database? _database;

  Future<Database> get database async =>
      _database ??= await _initiateDatabase();

  Future<Database> _initiateDatabase() async {
    final _box = GetStorage();

    String _directory = await getDatabasesPath();

    String _password = _databaseController.passwordOneController.text;

    String _databaseName = _box.read('databaseName');

    String _dbPath = _directory + '/' + _databaseName + '.db';

    return await openDatabase(_dbPath,
        version: 1, password: _password, onCreate: _onCreate);
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
