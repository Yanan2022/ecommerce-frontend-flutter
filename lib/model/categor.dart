import 'dart:convert';
import 'package:hive/hive.dart';

part 'categor.g.dart';

List<Categor> popularCategorListFromJson(String value) {
  final parsed = json.decode(value)['data'];
  return List<Categor>.from(
      parsed.map((category) => Categor.popularCategorFromJson(category)));
}

List<Categor> categorListFromJson(String value) {
  final parsed = json.decode(value)['data'];
  return List<Categor>.from(
      parsed.map((category) => Categor.categorFromJson(category)));
}

@HiveType(typeId: 2)
class Categor {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String image;

  Categor({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Categor.popularCategorFromJson(Map<String, dynamic> data) => Categor(
      id: data['id'],
      name: data['attributes']['category']['data']['attributes']['name'],
      image: data['attributes']['category']['data']['attributes']['image']
          ['data']['attributes']['url']);

  factory Categor.categorFromJson(Map<String, dynamic> data) => Categor(
      id: data['id'],
      name: data['attributes']['name'],
      image: data['attributes']['image']['data']['attributes']['url']);
}
