import 'package:flutter/material.dart';
import 'package:frontend/model/add_banner.dart';
import 'package:frontend/model/categor.dart';
import 'package:frontend/model/product.dart';
import 'package:frontend/route/app_page.dart';
import 'package:frontend/route/app_route.dart';
import 'package:get/get.dart';
import 'package:frontend/theme/app_theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  //register adapters
  Hive.registerAdapter(AddBannerAdapter());
  Hive.registerAdapter(CategorAdapter());
  Hive.registerAdapter(ProductAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPage.list,
      initialRoute: AppRoute.dashboard,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
    );
  }
}
