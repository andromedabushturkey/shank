import 'package:flutter/widgets.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shank/utils/db_helper_single.dart';

class DailyFinanceController extends GetxController {
  @override
  void onInit() async {
    var _getExpenses = await fetchListOfExpenses();
    setImagePath = await getDownloadsDirectory();
    listOfExpenses.value = _getExpenses;

    super.onInit();
  }

  MoneyMaskedTextController expenseTextController =
      MoneyMaskedTextController(decimalSeparator: '.', initialValue: 0.00);

  TextEditingController expenseDescriptionController = TextEditingController();
  TextEditingController expenseNotesController = TextEditingController();
  TextEditingController expenseDateController = TextEditingController();

  RxList<Map<String, dynamic>> listOfExpenses = RxList([]);

  RxString _imagePath = RxString('');
  String get imagePath => this._imagePath.value;
  set setImagePath(value) => this._imagePath.value = value;

  ImagePicker imagePicker = ImagePicker();

  //sets the lenght of how many items are in the daily db

  Future<List<Map<String, dynamic>>> fetchListOfExpenses() async {
    var _db = await DBHelperSingle.instance.database;
    final _box = GetStorage();
    String _dbName = _box.read('databaseName');
    String _tableName = _dbName + 'Daily';
    List<Map<String, dynamic>> _dbQuery = await _db.query(_tableName);
    return _dbQuery;
  }
}
