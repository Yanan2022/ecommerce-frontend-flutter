import 'package:flutter/material.dart';
import 'package:frontend/model/product.dart';
import 'package:frontend/view/home/component/popular-product/popular_product_card.dart';
import 'package:frontend/view/home/component/popular-product/popular_product_loading_card.dart';

class PopularProduct extends StatelessWidget {
  final List<Product> popularProduct;
  const PopularProduct({super.key, required this.popularProduct});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: const EdgeInsets.only(right: 10),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: popularProduct.length,
          itemBuilder: (context, index) => PopularProductCard(
                product: popularProduct[index],
              )),
    );
  }
}
