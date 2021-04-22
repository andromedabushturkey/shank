import 'package:get/get.dart';
import 'package:shank/screens/create_database.dart';
import 'package:shank/screens/home_page.dart';
import 'package:shank/screens/intro_page.dart';

class AppRoutes {
  static final route = [
    GetPage(name: '/createDatabase', page: () => CreateDatabase()),
    GetPage(name: '/homePage', page: () => HomePage()),
    GetPage(name: '/', page: () => IntroPage())
  ];
}
