import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class StartPage extends StatelessWidget {
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
              child: Column(
                children: [
                  Text(
                    'Shank will track and keep your finances in an encrypted database.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Shank will never share your personal information with anyone.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Shank. Private finances.',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () async {
                Get.toNamed('/createDatabase');
              },
              child: Text(
                "Let's Get Started!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            // AvailableDbList(createNewDbController: _createNewDbController),
          ],
        ),
      ),
    );
  }
}
