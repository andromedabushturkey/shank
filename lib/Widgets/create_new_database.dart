import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void showCreateDatabaseDialog() async {
  TextEditingController _databaseNameController = TextEditingController();
  TextEditingController _passwordOneController = TextEditingController();
  TextEditingController _passwordTwoController = TextEditingController();

  await Get.defaultDialog(
    title: 'Create new Database',
    content: Column(
      children: [
        TextField(
          controller: _databaseNameController,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white70,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              border: InputBorder.none,
              labelText: 'Enter Database Name',
              labelStyle: GoogleFonts.inconsolata(color: Colors.black),
              hintText: 'Enter Database Name'),
        ),
        SizedBox(height: 10),
        TextFormField(
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white70,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              border: InputBorder.none,
              labelText: 'Enter Database Password',
              labelStyle: GoogleFonts.inconsolata(color: Colors.black),
              hintText: 'Enter Database Password'),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white70,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              border: InputBorder.none,
              labelText: 'Confirm Database Password',
              labelStyle: GoogleFonts.inconsolata(color: Colors.black),
              hintText: 'Confirm Database Password'),
        ),
      ],
    ),
    cancel: TextButton(
      onPressed: () {
        Get.back();
      },
      child: Text('Cancel'),
    ),
    confirm: TextButton(
      onPressed: () {
        Get.back(result: _databaseNameController.text);
      },
      child: Text('Save'),
    ),
  );

  void _validateDatabasePasswords(
      {TextEditingController passwordOne, TextEditingController passwordTwo}) {}
}
