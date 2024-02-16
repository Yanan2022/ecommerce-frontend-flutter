import 'package:flutter/material.dart';
import 'package:frontend/component/main_header.dart';
import 'package:frontend/controller/controllers.dart';
import 'package:frontend/view/home/component/courousel_slider/carousel_loading.dart';
import 'package:frontend/view/home/component/courousel_slider/carousel_slider_view.dart';
import 'package:frontend/view/home/component/popular-category/popular_category_loading.dart';
import 'package:frontend/view/home/component/popular-category/popular_category.dart';
import 'package:frontend/view/home/component/popular-product/popular_product.dart';
import 'package:frontend/view/home/component/popular-product/popular_product_loading.dart';
import 'package:frontend/view/home/component/section_title.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        MainHeader(),
        Expanded(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Obx(() {
                if (homeController.bannerList.isNotEmpty) {
                  return CarouselSliderView(
                    bannerList: homeController.bannerList,
                  );
                } else {
                  return CarouselLoading();
                }
              }),
              const SectionTitle(title: "Categorie populaire"),
              Obx(() {
                if (homeController.popularCategorList.isNotEmpty) {
                  return PopularCategory(
                      categories: homeController.popularCategorList);
                } else {
                  return const PopularCategoryLoading();
                }
              }),
              const SectionTitle(title: "Produit populaire"),
              Obx(() {
                if (homeController.popularProductList.isNotEmpty) {
                  return PopularProduct(
                    popularProduct: homeController.popularProductList,
                  );
                } else {
                  return const PopularProductLoading();
                }
              }),
            ],
          ),
        )),
      ],
    ));
  }
}
