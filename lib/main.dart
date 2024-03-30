import 'package:flutter/material.dart';
import 'package:flutter_application_6/catalog.dart';
import 'package:flutter_application_6/categories_screen.dart';
import 'package:flutter_application_6/recipes.dart';
import 'package:flutter_application_6/weather_api.dart';
import 'package:flutter_application_6/weather_app.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async{
  await initializeDateFormatting('ru', null);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CategoriesScreen(),
    );
  }
}
