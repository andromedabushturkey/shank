import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Widgets/credit_finance_widget.dart';
import '../Widgets/daily_finance_widget.dart';
import '../Widgets/floating_action_button_widget.dart';
import '../Widgets/recurring_finance_widget.dart';
import '../controllers/bottom_nav_bar_controller.dart';
import '../models/account_balance.dart';
import '../utils/db_helper.dart';

class HomePage extends StatelessWidget {
  final BottomNavBarController _navBarController =
      Get.put<BottomNavBarController>(BottomNavBarController());

  final _selectedNavBarItem = [
    DailyFinanceWidget(),
    RecurringFinanceWidget(),
    CreditFinanceWidget()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Get.defaultDialog(
                title: 'Account Balance',
                middleText: 'Set or modify current account balance',
                content: Column(
                  children: [
                    TextField(
                        decoration: InputDecoration(
                            hintText: 'Set current account balance'),
                        controller: _navBarController.accountBalanceEditor)
                  ],
                ),
                onConfirm: () async {
                  String _accountBalance =
                      _navBarController.accountBalanceEditor.text;
                  AccountBalance _acctB = AccountBalance();
                  _acctB.accountBalance = double.parse(_accountBalance);
                  DBHelper _dbHelper = DBHelper();
                  try {
                    await _dbHelper.insertBalance(_acctB);
                  } catch (e, st) {
                    Get.snackbar('Error',
                        'Unable to modify the account balance. Please try again');
                  }
                },
                onCancel: () {},
              );
            },
            child: Icon(Icons.edit_outlined, color: Colors.black),
          )
        ],
        centerTitle: false,
        leadingWidth: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Account Balance: \$2830',
          textAlign: TextAlign.left,
          style: GoogleFonts.inconsolata(color: Colors.black),
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) => _navBarController.setSelectedIndex = index,
          currentIndex: _navBarController.selectedIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(AntIcons.dollar), label: 'Daily'),
            BottomNavigationBarItem(
                icon: Icon(AntIcons.retweet_outline), label: 'Recurring'),
            BottomNavigationBarItem(
                icon: Icon(AntIcons.credit_card_outline), label: 'Credit'),
          ],
        ),
      ),
      body: Obx(() => _selectedNavBarItem[_navBarController.selectedIndex]),
      floatingActionButton: FloatingActionButtonWidet(),
    );
  }
}
