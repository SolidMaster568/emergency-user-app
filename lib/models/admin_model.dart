import 'package:emg/models/category_model.dart';

class AdminModel {
  String id;
  String uid;
  String email;
  String firstname;
  String lastname;
  String mobile;

  CategoryModel categoryInfo;

  AdminModel(
      {required this.id,
      required this.uid,
      required this.email,
      required this.firstname,
      required this.lastname,
      required this.mobile,
      required this.categoryInfo});

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'email': email,
        'firstname': firstname,
        'lastname': lastname,
        'mobile': mobile,
        'category_info': categoryInfo.toJson(),
      };

  String getFullName() {
    return "$firstname  $lastname";
  }

  factory AdminModel.fromJson(Map<String, dynamic> map) {
    return AdminModel(
      id: map['id'] ?? map['_id'] ?? "",
      uid: map['uid'] ?? "",
      email: map['email'] ?? "",
      firstname: map['firstname'] ?? "",
      lastname: map['lastname'] ?? "",
      mobile: map['mobile'] ?? "",
      categoryInfo: map['category_info'] == null
          ? CategoryModel.fromJson({})
          : CategoryModel.fromJson(map['category_info']),
    );
  }
}
