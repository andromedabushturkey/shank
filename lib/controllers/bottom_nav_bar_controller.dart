import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBarController extends GetxController {
  TextEditingController accountBalanceEditor = TextEditingController();

  RxnInt _selectedIndex = RxnInt(0);

  int get selectedIndex => this._selectedIndex.value;

  set setSelectedIndex(index) => this._selectedIndex.value = index;
}
