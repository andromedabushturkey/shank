import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shank/controllers/create_new_db_controller.dart';
import 'package:shank/utils/db_helper.dart';

Future<void> showPasswordDialog(int index) async {
  CreateNewDbController _controller = Get.find<CreateNewDbController>();

  await Get.defaultDialog(
    title: 'Database Password',
    confirm: TextButton(
      onPressed: () async {
        FileSystemEntity _fileSysEntity = _controller.listOfAvailDb[index];
        String _filePath = _fileSysEntity.path;
        String _fileName = basename(_filePath);
        print('PASSWORD OPEN: $_fileName');

        await DBHelper.openDB(_fileName);
        Get.back();
      },
      child: Text('Ok'),
    ),
    cancel: TextButton(
      onPressed: () {
        Get.back();
      },
      child: Text('Cancel'),
    ),
    content: Column(
      children: [
        TextField(
          controller: _controller.passwordOneController,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Enter database password',
            labelText: 'Database password',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
