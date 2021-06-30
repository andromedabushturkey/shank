import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shank/utils/db_helper_single.dart';

import '../controllers/create_new_db_controller.dart';
import '../utils/db_helper.dart';

class CreateDatabase extends StatelessWidget {
  final CreateNewDbController _createDbController =
      Get.put<CreateNewDbController>(CreateNewDbController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        leading: Container(
          child: SvgPicture.asset(
            'assets/images/shankLogov3.svg',
          ),
          padding: EdgeInsets.all(4),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: Colors.green[50],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.all(20),
              elevation: 0,
              child: Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Text(
                      'SHANK',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Fill out the form below to get started.',
                      textAlign: TextAlign.left,
                    ),
                    Text('This will create the encrypted database.')
                  ],
                ),
              ),
            ),
            Text(
              'Enter Database Information',
              style: TextStyle(fontSize: 18),
            ),
            Card(
              color: Colors.green[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.all(30),
              elevation: 0,
              child: Container(
                padding: EdgeInsets.all(30),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildDatabaseName(),
                        _buildPassword(),
                        _buildConfirmPassword(),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('Cancel')),
                            TextButton(
                                onPressed: () async {
                                  bool isFormValid = await _validateForm();
                                  if (!isFormValid) return;
                                  _saveAndOpenDB();
                                },
                                child: Text('Confirm'))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  Future<bool> _validateForm() async {
    var _formValidate = _formKey.currentState?.validate();
    if (_formValidate != null) {
      if (!_formValidate) {
        return false;
      }
    }
    return true;
  }

  Future<void> _saveAndOpenDB() async {
    _formKey.currentState?.save();
    print('OPENING DB');
    Get.defaultDialog(
      title: 'Please wait',
      barrierDismissible: false,
      content: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Creating Database'), CircularProgressIndicator()],
        ),
      ),
    );

    //open DB
    // await DBHelper.initDB();
    await DBHelperSingle.instance.database;

    Get.offAndToNamed('/homePage');
  }

  Widget _buildDatabaseName() {
    return TextFormField(
      controller: _createDbController.databaseNameController,
      decoration: InputDecoration(labelText: 'Database Name'),
      validator: (String? value) {
        if (value != null) {
          if (value.isEmpty) {
            return "Database name can't be left blank";
          }
        } else {
          return "Database name can't be left blank";
        }
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      controller: _createDbController.passwordOneController,
      decoration: InputDecoration(labelText: 'Password'),
      validator: (String? value) {
        if (value != null) {
          if (value.isEmpty) {
            return "Password is required";
          } else if (_createDbController.passwordOneController.text !=
              _createDbController.passwordTwoController.text) {
            return "Passwords don't match";
          }
        }
      },
    );
  }

  Widget _buildConfirmPassword() {
    return TextFormField(
      controller: _createDbController.passwordTwoController,
      decoration: InputDecoration(labelText: 'Confirm Password'),
      validator: (String? value) {
        if (value != null) {
          if (value.isEmpty) {
            return "Password is required";
          } else if (_createDbController.passwordOneController.text !=
              _createDbController.passwordTwoController.text) {
            return "Passwords do not match";
          }
        }
      },
      keyboardType: TextInputType.visiblePassword,
    );
  }
}
