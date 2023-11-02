class UserModel {
  String id;
  String uid;
  String email;
  String firstname;
  String lastname;
  String photourl;
  String mobile;
  String dob;
  String blood_type;
  String height;
  String weight;
  String allergies;
  String devicetoken;
  String? registration_status;

  UserModel({
    required this.id,
    required this.uid,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.photourl,
    required this.mobile,
    required this.dob,
    required this.blood_type,
    required this.height,
    required this.weight,
    required this.allergies,
    required this.devicetoken,
    this.registration_status,
  });

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'email': email,
        'firstname': firstname,
        'lastname': lastname,
        'mobile': mobile,
        'photourl': photourl,
        'dob': dob,
        'blood_type': blood_type,
        'height': height,
        'weight': weight,
        'allergies': allergies,
        'devicetoken': devicetoken,
        'registration_status': registration_status,
      };

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? "",
      uid: map['uid'] ?? "",
      email: map['email'] ?? "",
      photourl: map['photourl'] ?? "",
      firstname: map['firstname'] ?? "",
      lastname: map['lastname'] ?? "",
      mobile: map['mobile'] ?? "",
      dob: map['dob'] ?? "",
      blood_type: map['blood_type'] ?? "",
      height: map['height'] ?? "",
      weight: map['weight'] ?? "",
      allergies: map['allergies'] ?? "",
      devicetoken: map['devicetoken'] ?? "",
      registration_status: map['registration_status'],
    );
  }

  String getFullName() {
    return "$firstname $lastname";
  }
}
