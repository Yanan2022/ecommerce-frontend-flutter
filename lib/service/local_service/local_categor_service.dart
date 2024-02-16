import 'package:frontend/model/categor.dart';
import 'package:hive/hive.dart';

class LocalCategorService {
  late Box<Categor> _popularCategorBox;
  late Box<Categor> _categorBox;

  Future<void> init() async {
    _popularCategorBox = await Hive.openBox<Categor>('PopularCategors');
    _categorBox = await Hive.openBox<Categor>('categors');
  }

  Future<void> assignAllPopularCategors(
      {required List<Categor> popularCategors}) async {
    await _popularCategorBox.clear();
    await _popularCategorBox.addAll(popularCategors);
  }

  Future<void> assignAllCategors({required List<Categor> categors}) async {
    await _categorBox.clear();
    await _categorBox.addAll(categors);
  }

  List<Categor> getPopularCategors() => _popularCategorBox.values.toList();
  List<Categor> getCategors() => _categorBox.values.toList();
}
