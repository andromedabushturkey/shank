import 'package:get/get.dart';

class BottomNavBarController extends GetxController {
  RxnInt _selectedIndex = RxnInt(0);

  int get selectedIndex => this._selectedIndex.value;

  set setSelectedIndex(index) => this._selectedIndex.value = index;
}
