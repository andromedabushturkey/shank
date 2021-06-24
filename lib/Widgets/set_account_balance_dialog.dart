import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showSetAccountBalance() async {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildDbPassword() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Set Account Balance'),
      validator: (String? value) {
        if (value != null) {
          if (value.isEmpty) return "Ammount can't be left blank";
        }
      },
    );
  }

  await Get.defaultDialog(
    barrierDismissible: false,
    title: 'Set Account Balance',
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
                              onPressed: () async {}, child: Text('Open')),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
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
