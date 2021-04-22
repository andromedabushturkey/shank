import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shank/controllers/bindings/initial_bindings.dart';
import 'package:shank/routes/app_routes.dart';
import 'package:shank/screens/create_database.dart';
import 'package:shank/screens/intro_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBindings(),
      initialRoute: '/',
      getPages: AppRoutes.route,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.inconsolataTextTheme(),
      ),
    );
  }
}
