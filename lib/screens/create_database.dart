import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shank/controllers/create_new_db_controller.dart';
import 'package:shank/utils/db_helper.dart';

class CreateDatabase extends StatelessWidget {
  final CreateNewDbController _createDbController =
      Get.put<CreateNewDbController>(CreateNewDbController());

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Database Information',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Card(
              // color: Color.fromRGBO(217, 213, 202, .8),
              color: Colors.green[50],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.all(10),
              elevation: 0,
              child: Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                      () => TextFormField(
                        controller: _createDbController.databaseNameController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide:
                                    BorderSide(color: Colors.green, width: 4)),
                            errorText: _createDbController.dbNameError,
                            filled: true,
                            fillColor: Colors.white70,
                            labelText: 'Database Name',
                            labelStyle:
                                GoogleFonts.inconsolata(color: Colors.black),
                            hintText: 'Enter Database Name'),
                      ),
                    ),
                    SizedBox(height: 10),
                    Obx(
                      () => TextFormField(
                        controller: _createDbController.passwordOneController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide:
                                    BorderSide(color: Colors.green, width: 4)),
                            errorText: _createDbController.dbNameError,
                            filled: true,
                            fillColor: Colors.white70,
                            labelText: 'Database Password',
                            labelStyle:
                                GoogleFonts.inconsolata(color: Colors.black),
                            hintText: 'Enter Database Password'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => TextFormField(
                        controller: _createDbController.passwordTwoController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide:
                                    BorderSide(color: Colors.green, width: 4)),
                            errorText: _createDbController.dbNameError,
                            filled: true,
                            fillColor: Colors.white70,
                            labelText: 'Confirm Database Password',
                            labelStyle:
                                GoogleFonts.inconsolata(color: Colors.black),
                            hintText: 'Confirm Database Password'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.offNamed('/');
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                            onPressed: () {
                              if (_createDbController
                                  .validateNewDatabaseForm()) {
                                DBHelper.initDB();
                              } else {
                                return;
                              }
                              //!Create database call here
                              Get.offNamed('/homePage');
                            },
                            child: Text('Save'))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
