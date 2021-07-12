import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shank/controllers/daily_finance_controller.dart';

import '../../controllers/account_balance_controller.dart';

class DailyFinanceWidget extends StatelessWidget {
  final acController =
      Get.put<AccountBalanceController>(AccountBalanceController());
  final _dailyFinanceController =
      Get.put<DailyFinanceController>(DailyFinanceController());
  @override
  Widget build(BuildContext context) {
    var num = _dailyFinanceController.listOfExpenses;
    print('NUMBER: $num');
    return Container(
      child: Obx(() => ListView.builder(
            itemCount: _dailyFinanceController.listOfExpenses.length,
            itemBuilder: (context, index) {
              String _description =
                  _dailyFinanceController.listOfExpenses[index]['Description'];

              String _notes =
                  _dailyFinanceController.listOfExpenses[index]['Notes'];

              String _expense =
                  _dailyFinanceController.listOfExpenses[index]['Expense'];

              String _date =
                  _dailyFinanceController.listOfExpenses[index]['Date'];

              return ExpansionTile(
                childrenPadding: EdgeInsets.all(12),
                title: Text(
                  _description,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(_notes),
                trailing: Text(
                  _expense,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text('Expense date: '), Text(_date)],
                  )
                ],
              );
            },
          )),
    );
  }
}
