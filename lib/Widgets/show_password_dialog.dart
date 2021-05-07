import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shank/controllers/create_new_db_controller.dart';
import 'package:shank/utils/db_helper.dart';

Future<void> showPasswordDialog(int index) async {
  CreateNewDbController _controller = Get.find<CreateNewDbController>();

  await Get.defaultDialog(
    title: 'Database Password',
    confirm: TextButton(
      onPressed: () {
        DBHelper.openDB(_controller.listOfAvailDb[index]);
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
