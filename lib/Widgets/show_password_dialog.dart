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
      decoration: InputDecoration(labelText: 'Enter Database Password'),
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

  await Get.defaultDialog(
    barrierDismissible: false,
    title: 'Database Password',
    content: Card(
      color: Colors.green[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 24),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Container(
                child: Obx(
                  () => Column(
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
                                bool _openDatabase =
                                    await DBHelper.openDB(_fileName);
                                print('DB OPEN Status: ');

                                if (_openDatabase) {
                                  Get.offAndToNamed('/homePage');
                                } else {
                                  Get.back();
                                }
                              },
                              child: Text('Open')),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      (_controller.openDBErrorMsg == null)
                          ? Text('')
                          : Text(
                              _controller.openDBErrorMsg!,
                              style: TextStyle(color: Colors.red),
                            )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
