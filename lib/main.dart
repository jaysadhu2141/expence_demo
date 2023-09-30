import 'package:expence_demo/resource/app_colors.dart';
import 'package:expence_demo/screen/screen_expence_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/get_routes.dart';





void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense App',
      theme: ThemeData(primarySwatch:  Colors.purple),
      home: ExpenseList(),
      getPages: AppPages.pages,
    );
  }
}