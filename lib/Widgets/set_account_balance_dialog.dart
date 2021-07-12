import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/account_balance_controller.dart';
import '../models/account_balance.dart';
import '../utils/db_helper_single.dart';

Future<void> showSetAccountBalance() async {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AccountBalanceController _accountBalanceController =
      Get.find<AccountBalanceController>();

  Widget _buildSetAccount() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _accountBalanceController.accountBalanceEditor,
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
                child: Column(
                  children: [
                    _buildSetAccount(),
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
                            onPressed: () async {
                              final _box = GetStorage();
                              String _databaseName = _box.read('databaseName');
                              if (_formKey.currentState != null) {
                                _formKey.currentState!.validate();
                                var _accountBalanceMap = AccountBalance.toMap(
                                    _accountBalanceController
                                        .accountBalanceEditor.text);

                                var _db =
                                    await DBHelperSingle.instance.database;
                                String _tableName = _databaseName + 'Balance';

                                var _checkFirstDeposit = await _db.query(
                                    _tableName,
                                    columns: ['Balance'],
                                    where: 'id=?',
                                    whereArgs: [1]);
                                if (_checkFirstDeposit.length == 0) {
                                  print('accountBalance: $_accountBalanceMap');
                                  print(
                                      'textEditorValue: ${_accountBalanceController.accountBalanceEditor.text}');
                                  await _db.insert(
                                      _tableName, _accountBalanceMap);

                                  await _accountBalanceController.getBalance();
                                  // _accountBalanceController.accountBalanceEditor
                                  //     .clear();
                                  Get.back();
                                } else {
                                  _db.update(_tableName, _accountBalanceMap,
                                      where: 'id = ?', whereArgs: [1]);
                                  _accountBalanceController.getBalance();
                                  Get.back();
                                }
                              }
                            },
                            child: Text('Set')),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
