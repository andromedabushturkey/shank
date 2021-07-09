import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shank/controllers/daily_finance_controller.dart';

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
                          SizedBox(
                            height: 26,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.offAndToNamed('/homePage');
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                  onPressed: () {
                                    var _formState = _formKey.currentState;
                                    if (_formState != null) {
                                      _formState.validate();
                                    }
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
            ],
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
        }
      },
    );
  }
}
