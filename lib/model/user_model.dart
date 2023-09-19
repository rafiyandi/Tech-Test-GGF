class UserModel {
  String? id;
  String? name;
  String? avatar;
  String? createdAt;

  UserModel({this.id, this.name, this.avatar, this.createdAt});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      createdAt: json['createdAt']);

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}
