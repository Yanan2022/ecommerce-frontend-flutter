import 'package:flutter/material.dart';
import 'package:frontend/component/main_header.dart';
import 'package:frontend/controller/controllers.dart';
import 'package:frontend/view/product/components/product_grid.dart';
import 'package:frontend/view/product/components/product_loading_grid.dart';
import 'package:get/get.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          MainHeader(),
          Expanded(child: Obx(() {
            if (productController.productList.isNotEmpty) {
              return ProductGrid(products: productController.productList);
            } else {
              return const ProductLoadingGrid();
            }
          })),
        ],
      ),
    );
  }
}
