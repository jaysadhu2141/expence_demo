import 'package:expence_demo/binding/binding_expence_list.dart';
import 'package:expence_demo/screen/screen_expence_list.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';



class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: ExpenseList.pageId,
      page: () => ExpenseList(),
      binding: ExpenceListBinding(),
    ),
  ];
}