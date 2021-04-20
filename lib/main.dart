import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shank/src/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(MyApp());
}
