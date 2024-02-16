import 'package:flutter/material.dart';
import 'package:frontend/view/home/component/popular-category/popular_category_card.dart';
import 'package:frontend/model/categor.dart';

class PopularCategory extends StatelessWidget {
  final List<Categor> categories;
  const PopularCategory({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: const EdgeInsets.only(right: 10),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: categories.length,
          itemBuilder: (context, index) =>
              PopularCategoryCard(categor: categories[index])),
    );
  }
}
