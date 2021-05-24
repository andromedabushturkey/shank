import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shank/controllers/account_balance_controller.dart';
import 'package:shank/models/account_balance.dart';

class DailyFinanceWidget extends StatelessWidget {
  var acController =
      Get.put<AccountBalanceController>(AccountBalanceController());
  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: ElevatedButton(
      onPressed: () async {
        var tester = await acController.getBalance();
        print('tester: $tester');
      },
    )));
  }
}
