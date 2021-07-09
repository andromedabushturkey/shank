import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/account_balance_controller.dart';

class DailyFinanceWidget extends StatelessWidget {
  final acController =
      Get.put<AccountBalanceController>(AccountBalanceController());
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: ElevatedButton(
      child: Text('press me'),
      onPressed: () async {
        var tester = await acController.getBalance();
        print('tester: $tester');
      },
    )));
  }
}
