import 'package:frontend/model/categor.dart';
import 'package:frontend/service/local_service/local_categor_service.dart';
import 'package:frontend/service/remote_service/remote_category_service.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController instance = Get.find();
  RxList<Categor> categorList = List<Categor>.empty(growable: true).obs;
  final LocalCategorService _localCategorService = LocalCategorService();
  RxBool isCategorLoading = false.obs;

  @override
  void onInit() async {
    await _localCategorService.init();
    getCatgories();
    super.onInit();
  }

  void getCatgories() async {
    try {
      isCategorLoading(true);

      if (_localCategorService.getCategors().isNotEmpty) {
        categorList.assignAll(_localCategorService.getCategors());
      }
      var result = await RemoteCategoryService().get();
      if (result != null) {
        categorList.assignAll(categorListFromJson(result.body));
        _localCategorService.assignAllCategors(
            categors: categorListFromJson(result.body));
      }
    } finally {
      isCategorLoading(true);
    }
  }
}
