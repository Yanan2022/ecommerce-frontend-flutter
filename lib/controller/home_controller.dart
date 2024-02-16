import 'package:flutter/foundation.dart';
import 'package:frontend/model/add_banner.dart';
import 'package:frontend/model/categor.dart';
import 'package:frontend/model/product.dart';
import 'package:frontend/service/local_service/local_add_banner_service.dart';
import 'package:frontend/service/local_service/local_categor_service.dart';
import 'package:frontend/service/local_service/local_product_service.dart';
import 'package:frontend/service/remote_service/remote_banner_service.dart';
import 'package:frontend/service/remote_service/remote_popular_Categor_service.dart';
import 'package:frontend/service/remote_service/remote_popular_product_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController instance = Get.find();
  RxList<AddBanner> bannerList = List<AddBanner>.empty(growable: true).obs;
  RxList<Categor> popularCategorList = List<Categor>.empty(growable: true).obs;
  RxList<Product> popularProductList = List<Product>.empty(growable: true).obs;
  RxBool isBannerLoading = false.obs;
  RxBool isPopularCategorLoading = false.obs;
  RxBool isPopularProductLoading = false.obs;
  final LocalAddBannerService _localAddBannerService = LocalAddBannerService();
  final LocalCategorService _localCategorService = LocalCategorService();
  final LocalProductService _localProductService = LocalProductService();

  @override
  void onInit() async {
    await _localAddBannerService.init();
    await _localCategorService.init();
    await _localProductService.init();
    getAddBanner();
    getPopularCategories();
    getPopularProducts();
    super.onInit();
  }

  void getAddBanner() async {
    try {
      isBannerLoading(true);

      //assigning local add banner before call api
      if (_localAddBannerService.getAddBanners().isNotEmpty) {
        bannerList.assignAll(_localAddBannerService.getAddBanners());
      }
      //call api
      var result = await RemoteBannerService().get();
      if (result != null) {
        //assign api resultt
        bannerList.assignAll(addBannerListFromJson(result.body));
        //save api result to local db
        _localAddBannerService.assignAllAddBanners(
            addBanners: addBannerListFromJson(result.body));
      }
    } finally {
      // print(bannerList.length);
      isBannerLoading(false);
    }
  }

  void getPopularCategories() async {
    try {
      isPopularCategorLoading(true);
      if (_localCategorService.getPopularCategors().isNotEmpty) {
        popularCategorList.assignAll(_localCategorService.getPopularCategors());
      }

      var result = await RemotePopularCategorService().get();
      if (result != null) {
        popularCategorList.assignAll(popularCategorListFromJson(result.body));
        _localCategorService.assignAllPopularCategors(
            popularCategors: popularCategorListFromJson(result.body));
      }
    } finally {
      // print(popularCategorList.length);
      isPopularCategorLoading(false);
    }
  }

  void getPopularProducts() async {
    try {
      isPopularProductLoading(true);
      if (_localProductService.getPopularProducts().isNotEmpty) {
        popularProductList.assignAll(_localProductService.getPopularProducts());
      }

      var result = await RemotePopularProductService().get();
      if (result != null) {
        popularProductList.assignAll(popularProductListFromJson(result.body));
        _localProductService.assignAllPopularProducts(
            popularProducts: popularProductListFromJson(result.body));
      }
    } finally {
      print(popularProductList.length);
      isPopularProductLoading(false);
    }
  }
}
