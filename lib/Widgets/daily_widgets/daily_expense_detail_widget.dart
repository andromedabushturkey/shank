import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shank/controllers/daily_finance_controller.dart';
import 'package:shank/models/daily_model.dart';
import 'package:shank/utils/db_helper_single.dart';

class DailyExpenseDetailWidget extends StatelessWidget {
  DailyExpenseDetailWidget({Key? key}) : super(key: key);

  final DailyFinanceController _dailyFinanceController =
      Get.put(DailyFinanceController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyDateTime = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Expense Details',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.green[50],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(left: 16, right: 16, top: 24),
                      child: Form(
                        key: _formKey,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              _buildExpenseForm(),
                              _buildExpenseDescription(),
                              _buildExpenseNotes(),
                              _buildExpenseDate(),
                              _buildExpensePicture(),
                              SizedBox(
                                height: 26,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Get.offAndToNamed('/homePage');
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                      onPressed: () async {
                                        var _formState = _formKey.currentState;
                                        if (_formState != null) {
                                          _formState.validate();
                                          var _db = await DBHelperSingle
                                              .instance.database;
                                          Map<String,
                                              dynamic> _expenseObject = DailyModel(
                                                  _dailyFinanceController
                                                      .expenseDateController
                                                      .text,
                                                  _dailyFinanceController
                                                      .expenseDescriptionController
                                                      .text,
                                                  '0',
                                                  _dailyFinanceController
                                                      .expenseTextController
                                                      .text,
                                                  _dailyFinanceController
                                                      .expenseNotesController
                                                      .text)
                                              .toMap();
                                          print(
                                              'EXPENSE OBJECT: $_expenseObject');
                                          var _box = GetStorage();
                                          String _dbName =
                                              _box.read('databaseName');
                                          String _tableName = _dbName + 'Daily';

                                          await _db.insert(
                                              _tableName, _expenseObject);
                                          Get.offAndToNamed('/homePage');
                                        }
                                        _dailyFinanceController
                                            .fetchListOfExpenses();
                                      },
                                      child: Text('Save'))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpenseForm() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Expense Amount'),
      controller: _dailyFinanceController.expenseTextController,
      validator: (value) {
        if (value != null) {
          if (value.isEmpty) return 'This field is required';
        }
      },
    );
  }

  Widget _buildExpenseDescription() {
    return TextFormField(
      maxLines: null,
      decoration: InputDecoration(labelText: 'Expense Description'),
      controller: _dailyFinanceController.expenseDescriptionController,
      validator: (value) {
        if (value != null) {
          if (value.isEmpty) return 'This field is required';
        }
      },
    );
  }

  Widget _buildExpenseNotes() {
    return TextFormField(
      maxLines: null,
      decoration: InputDecoration(labelText: 'Additional Expense Notes'),
      controller: _dailyFinanceController.expenseNotesController,
    );
  }

  Widget _buildExpenseDate() {
    return DateTimePicker(
      calendarTitle: 'Expense Date',
      dateLabelText: 'Expense Date and Time',
      key: _formKeyDateTime,
      type: DateTimePickerType.dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      controller: _dailyFinanceController.expenseDateController,
      validator: (value) {
        if (value != null) {
          if (value.isEmpty) return 'This field is required';
          print('VALUE: $value');
        }
      },
    );
  }

  Widget _buildExpensePicture() {
    String _imagePath = _dailyFinanceController.imagePath;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.file(File(_imagePath)),
        IconButton(
            onPressed: () {
              _takePicture();
            },
            icon: Icon(Icons.camera_alt_outlined))
      ],
    );
  }

  void _takePicture() async {
    ImagePicker _imagepicker = ImagePicker();
    PickedFile? _picker =
        await _imagepicker.getImage(source: ImageSource.camera);
    if (_picker != null) {
      _dailyFinanceController.setImagePath = _picker.path;
    }
  }
}
