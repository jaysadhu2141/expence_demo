import 'package:expence_demo/controller/controller_expence_list.dart';
import 'package:get/instance_manager.dart';





class ExpenceListBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ExpenceListController>(() =>  ExpenceListController());
  }

}