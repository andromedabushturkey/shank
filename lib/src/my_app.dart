import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/bindings/initial_bindings.dart';
import '../routes/app_routes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBindings(),
      initialRoute: getInitialRoute(),
      getPages: AppRoutes.route,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.inconsolataTextTheme(),
      ),
    );
  }

  String getInitialRoute() {
    var _box = GetStorage();
    String? _initialRoute = _box.read('config');

    if (_initialRoute == null) {
      return '/startPage';
    } else {
      return '/introPage';
    }
  }
}
