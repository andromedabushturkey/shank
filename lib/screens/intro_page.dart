import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shank/Widgets/available_db_list.dart';
import 'package:shank/controllers/create_new_db_controller.dart';

class IntroPage extends StatelessWidget {
  final CreateNewDbController _createNewDbController =
      Get.find<CreateNewDbController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/shankLogov3.svg'),
            Container(
              margin: EdgeInsets.fromLTRB(60, 0, 40, 60),
              // child: Text(
              //   'Your finances are stored in an encrypted database on your device.',
              //   style: TextStyle(fontSize: 16),
              // ),
            ),
            SizedBox(
              height: 5,
            ),
            // TextButton(
            //     onPressed: () async {
            //       Get.toNamed('/createDatabase');
            //     },
            //     child: Text('Create New Database')),
            Text(
              'Database Control Center',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            AvailableDbList(createNewDbController: _createNewDbController),
          ],
        ),
      ),
    );
  }
}
