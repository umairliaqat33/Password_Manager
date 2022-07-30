class UserModel {
  String? id;
  String? name;
  String? email;

  UserModel({this.id, this.name, this.email});

  factory UserModel.fromMap(map) {
    return UserModel(id: map['id'], name: map['Name'], email: map['Email']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Email': email,
      'Name': name,
    };
  }
}
