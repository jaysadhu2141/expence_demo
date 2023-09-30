
import 'package:expence_demo/Widget/toast.dart';
import 'package:expence_demo/controller/base_controller.dart';
import 'package:expence_demo/database/database_helper.dart';
import 'package:expence_demo/model/model_expense.dart';
import 'package:expence_demo/resource/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';

class ExpenceListController extends BaseController {

  TextEditingController tcTitle = TextEditingController();
  TextEditingController tcAmount= TextEditingController();

  final dbHelper = DatabaseHelper.instance;
  final expenseList = <ModelExpense>[].obs;

  @override
  void onInit() {
    super.onInit();
getExpenseList();
  }
  @override
  void errorHandler() {

  }

  Future<void> getExpenseList() async {
    expenseList.clear();
    try {
      String sql = '''SELECT * 
     FROM ${DatabaseHelper.tableExpense}''';
      final List<Map<String, dynamic>> list = await dbHelper.customQuery(sql);
      expenseList.value = list.map((e) => ModelExpense.fromJson(e)).toList();
      update();
    } catch (e) {

    }
  }


  Future<void> deleteExpense(BuildContext? context,{int? i}) async{

    final dbHelper = DatabaseHelper.instance;
    int indexStore = expenseList
        .indexWhere((element) => element.id ==  expenseList[i!].id);

    String sql = '''DELETE FROM ${DatabaseHelper.tableExpense} 
          WHERE ${DatabaseHelper.colId}='${expenseList[indexStore].id}'
          ''';

    AppHelper.showLog('Delete cart sql: $sql');

    await dbHelper.customQuery(sql).then((value) {
      getExpenseList();
      Toast.show(context!, 'Deleted Successfully');
    });
  }


  Future<void> showAlertDialog(BuildContext? context,{int? index}) async {
    return showDialog<void>(
      context: context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Expense'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want to delete expense?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () async{
                Navigator.of(context).pop();
                deleteExpense(context, i: index!);


              },
            ),
          ],
        );
      },
    );
  }
}