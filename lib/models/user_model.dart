class UserModel {
  String? uid;
  String? name;
  String? lastName;
  String? avatarUrl;
  String? phoneNumber;

  UserModel({this.uid, this.name, this.avatarUrl, this.lastName, this.phoneNumber});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'] ?? '';
    name = json['name'] ?? '';
    lastName = json['lastName'] ?? '';
    avatarUrl = json['avatarUrl'] ?? '';
    phoneNumber = json['phoneNumber'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['uid'] = uid;
    json['name'] = name;
    json['lastName'] = lastName;
    json['avatarUrl'] = avatarUrl;
    json['phoneNumber'] = phoneNumber;
    return json;
  }
}
