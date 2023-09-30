import 'package:expence_demo/Widget/primary_button.dart';
import 'package:expence_demo/Widget/toast.dart';
import 'package:expence_demo/controller/controller_expence_list.dart';
import 'package:expence_demo/database/database_helper.dart';
import 'package:expence_demo/device/device_utils.dart';
import 'package:expence_demo/resource/app_colors.dart';
import 'package:expence_demo/resource/app_helper.dart';
import 'package:expence_demo/resource/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExpenseList extends GetView<ExpenceListController> {
  ExpenseList({Key? key}) : super(key: key);
  static String pageId = "/home";
  final controllerr = Get.put(ExpenceListController());
  final formKey = GlobalKey<FormState>();
  FocusNode titleFocusNode = FocusNode();
  FocusNode amountFocusNode = FocusNode();
  RxString selectedDate = ''.obs;
  RxString storeDate = ''.obs;

  DateTime? picked;


  void addExpenseBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        context: ctx,
        builder: (ctx) => Container(
              height: DeviceUtils.getScaledHeight(ctx, 0.70),
              color: Colors.white54,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controllerr.tcTitle,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        maxLength: 15,
                        focusNode: titleFocusNode,
                        cursorColor: AppColors.purple,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'Enter your title',
                          labelStyle: TextStyle(
                              color: titleFocusNode.hasFocus
                                  ? AppColors.purple
                                  : Colors.black),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: AppColors.purple),
                          ),
                        ),


                        validator: ((value) {
                          if(controllerr.tcTitle.text.isEmpty || controllerr.tcTitle.text == ''){
                            return 'Enter Title';
                          }
                          return null;
                        }),
                      ),
                      TextFormField(
                        controller: controllerr.tcAmount,
                        keyboardType: TextInputType.number,
                        cursorColor: AppColors.purple,
                        focusNode: amountFocusNode,
                        maxLength: 3,

                        validator: ((value) {
                          if(controllerr.tcAmount.text.isEmpty || controllerr.tcAmount.text == ''){
                            return 'Enter Amount';
                          }
                          return null;
                        }),
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'Enter your amount',
                          labelStyle: TextStyle(
                              color: amountFocusNode.hasFocus
                                  ? AppColors.purple
                                  : Colors.black),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: AppColors.purple),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(selectedDate.value.isEmpty
                                    ? 'No Date Chosen!'
                                    : 'Picked Date: ${selectedDate.value}'),
                                InkWell(
                                    onTap: () async {
                                      AppHelper.hideKeyboard(ctx);

                                      picked = await showDatePicker(
                                          context: ctx,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2030));
                                      storeDate.value =
                                          DateFormat('dd/MM/yyyy').format(picked!);
                                      if (storeDate.value.isNotEmpty &&
                                          storeDate.value != selectedDate.value) {
                                        selectedDate.value = storeDate.value;
                                      }
                                    },
                                    child: Text(
                                      'Choose Date',
                                      style: TextStyle(
                                        fontSize: 16,
                                          color: AppColors.purple,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ],
                        ),

                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PrimaryButton(
                            onPressed: () async {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      final dbHelper = DatabaseHelper.instance;
      await dbHelper.insert(
        DatabaseHelper.tableExpense,
        {
          DatabaseHelper.colTitle:
          controllerr.tcTitle.text,
          DatabaseHelper.colAmount:
          controllerr.tcAmount.text,
          DatabaseHelper.colDate: selectedDate.value,
        },
      ).then((value){
        Toast.show(ctx, 'Added Successfully');
        controllerr.getExpenseList().then((value) {
          controllerr.tcAmount.clear();
          controllerr.tcTitle.clear();
          selectedDate.value = '';
          Get.back();
        });
      });

    }
                            },
                            height: DeviceUtils.getScaledHeight(ctx, 0.06),
                            width: DeviceUtils.getScaledWidth(ctx, 0.40),
                            text: 'Add Transaction',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.black),
        backgroundColor: AppColors.purple,
        title: Text(
          'Personal Expense',
          style: TextStyle(
              fontSize: 18,
              color: AppColors.white,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                addExpenseBottomSheet(context);
              },
              child: Icon(
                Icons.add,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
            () => controllerr.expenseList.isEmpty
      ? Center(
      child: Column(
        children: [
      SizedBox(
      height: DeviceUtils.getScaledHeight(context, 0.40),),
          Text(
            'No Data',
            style: TextStyle(
                fontSize: 18,
                color: AppColors.purple,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    )
        :
    SizedBox(
              height: DeviceUtils.getScaledHeight(context, 0.70),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controllerr.expenseList.length,
                  itemBuilder: (context, int index) {
                    return AppStyle.expenseListBox(context,
                              title: controllerr.expenseList[index].title,
                              amount: controllerr.expenseList[index].amount,
                              date: controllerr.expenseList[index].date,
                        onPressed: ()async {
                      controllerr.showAlertDialog(context, index: index);
                        }
                    );
                  }),
            ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.yellow,
        onPressed: () {
          addExpenseBottomSheet(context);
        },
        child: Icon(
          Icons.add,
          color: AppColors.black,
        ),
      ),
    );
  }
}
