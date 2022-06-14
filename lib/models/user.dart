class User {
  int? id;
  String? name;
  String? password;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.name,
    this.password,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['password'] = password;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class AuthData {
  int? id;
  String? name;
  String? lastLogin;

  AuthData({
    this.id,
    this.name,
    this.lastLogin,
  });

  AuthData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    lastLogin = json['last_login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['last_login'] = lastLogin;
    return data;
  }
}
