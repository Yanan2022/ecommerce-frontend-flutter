import 'package:frontend/model/add_banner.dart';
import 'package:hive/hive.dart';

class LocalAddBannerService {
  late Box<AddBanner> _addBannerBox;

  Future<void> init() async {
    _addBannerBox = await Hive.openBox<AddBanner>('AddBanners');
  }

  Future<void> assignAllAddBanners(
      {required List<AddBanner> addBanners}) async {
    await _addBannerBox.clear();
    await _addBannerBox.addAll(addBanners);
  }

  List<AddBanner> getAddBanners() => _addBannerBox.values.toList();
}
