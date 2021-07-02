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
      onReady: () async {
        await _checkAppConfig()
            ? Get.toNamed('/introPage')
            : Get.toNamed('/startPage');
      },
      initialBinding: InitialBindings(),
      initialRoute: '/',
      getPages: AppRoutes.route,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.inconsolataTextTheme(),
      ),
    );
  }

  Future<bool> _checkAppConfig() async {
    var _storageBox = GetStorage();
    var _getConfig = _storageBox.read('config');
    print('CONFIG: $_getConfig');

    if (_getConfig == null) {
      return false;
    }
    return true;
  }
}
