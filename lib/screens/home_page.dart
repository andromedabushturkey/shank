import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Widgets/credit_finance_widget.dart';
import '../Widgets/daily_finance_widget.dart';
import '../Widgets/floating_action_button_widget.dart';
import '../Widgets/recurring_finance_widget.dart';
import '../Widgets/set_account_balance_dialog.dart';
import '../controllers/account_balance_controller.dart';
import '../controllers/bottom_nav_bar_controller.dart';

class HomePage extends StatelessWidget {
  final BottomNavBarController _navBarController =
      Get.put<BottomNavBarController>(BottomNavBarController());

  final AccountBalanceController _accountBalanceController =
      Get.put<AccountBalanceController>(AccountBalanceController());

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
            onTap: () async {
              await showSetAccountBalance();
            },
            child: Container(
              padding: EdgeInsets.only(right: 40),
              child: Icon(
                Icons.edit_outlined,
                color: Colors.black,
                size: 18,
              ),
            ),
          )
        ],
        centerTitle: false,
        leadingWidth: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Obx(() => Text(
              'Account Balance: \$ ${_accountBalanceController.accountBalance}',
              textAlign: TextAlign.left,
              style: GoogleFonts.inconsolata(color: Colors.black),
            )),
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
