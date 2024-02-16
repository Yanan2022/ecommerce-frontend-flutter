import 'package:frontend/controller/category_controller.dart';
import 'package:frontend/controller/dashboard_controller.dart';
import 'package:frontend/controller/home_controller.dart';
import 'package:frontend/controller/product_controller.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(HomeController());
    Get.put(ProductController());
    Get.put(CategoryController());
  }
}
