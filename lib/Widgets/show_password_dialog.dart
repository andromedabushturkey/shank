import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shank/controllers/create_new_db_controller.dart';
import 'package:shank/utils/db_helper.dart';

Future<void> showPasswordDialog(int index) async {
  CreateNewDbController _controller = Get.find<CreateNewDbController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildDbPassword() {
    return TextFormField(
      controller: _controller.passwordOneController,
      validator: (String? value) {
        if (value != null) {
          if (value.isEmpty) return "Password is required";
        }
      },
    );
  }

  Future<dynamic> _buildCircularProgressIndicator() {
    return Get.defaultDialog(
        title: 'Opening Database',
        barrierDismissible: false,
        content: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Please wait....'), CircularProgressIndicator()],
          ),
        ));
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

  await Get.defaultDialog(
    title: 'Enter Database Password',
    content: Column(
      children: [
        Form(
          key: _formKey,
          child: Container(
            child: Column(
              children: [
                _buildDbPassword(),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                        onPressed: () async {
                          _buildCircularProgressIndicator();
                          FileSystemEntity _fileSysEntity =
                              _controller.listOfAvailDb[index];
                          String _filePath = _fileSysEntity.path;
                          String _fileName = basename(_filePath);
                          bool _openDatabase = await DBHelper.openDB(_fileName);
                          print('DB OPEN Status: $_openDatabase');

                          if (_openDatabase) {
                            Get.offAndToNamed('/homePage');
                          } else {
                            Get.back();
                          }
                        },
                        child: Text('Open'))
                  ],
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}
