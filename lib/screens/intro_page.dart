import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class IntroPage extends StatelessWidget {
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
            child: Text(
              'Your finances are stored in an encrypted database on your device.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Text('Would you like to:'),
          SizedBox(
            height: 12,
          ),
          TextButton(
              onPressed: () async {
                Get.toNamed('/createDatabase');
              },
              child: Text('Create New Database')),
          TextButton(onPressed: () {}, child: Text('Open Existing')),
        ],
      )),
    );
  }
}
