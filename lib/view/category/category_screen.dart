import 'package:flutter/material.dart';
import 'package:frontend/controller/controllers.dart';
import 'package:frontend/view/category/components/category_card.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (categoryController.categorList.isNotEmpty) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: categoryController.categorList.length,
          itemBuilder: ((context, index) =>
              CategoryCard(category: categoryController.categorList[index])),
        );
      } else {
        return Container();
      }
    });
  }
}
