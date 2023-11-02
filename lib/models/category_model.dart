import 'package:emg/utils/const.dart';

class CategoryModel {
  String id;
  String name;
  String details;

  String icon;
  DateTime date;

  CategoryModel({
    required this.id,
    required this.name,
    required this.details,
    required this.icon,
    required this.date,
  });

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'details': details, 'date': date, 'icon': icon};

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      icon: map['icon'] ?? "",
      details: map['details'] ?? "",
      date:
          (map['date'] == null) ? DateTime.now() : DateTime.parse(map['date']),
    );
  }

  String getPhotoUrl() {
    if (icon == "") {
      return "";
    } else {
      return "$kStorageUrl/$icon";
    }
  }
}
