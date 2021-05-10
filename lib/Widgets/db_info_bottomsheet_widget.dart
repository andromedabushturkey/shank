import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shank/controllers/create_new_db_controller.dart';

class DbInfoBottomSheetWidget extends StatelessWidget {
  final int index;
  DbInfoBottomSheetWidget(this.index);
  final _controller = Get.find<CreateNewDbController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white70,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      margin: EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Database Hash:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text('${_controller.getDBDigest(index)}', style: TextStyle(fontSize: 16)),
          SizedBox(height: 10),
          Text('Last Modified:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text('${_controller.getDBLastModDdate(index)}', style: TextStyle(fontSize: 16))
        ],
      ),
    );
  }
}