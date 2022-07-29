class UserModel {
  String? id;
  String? name;
  String? email;

  //receiving data from firebase
  UserModel({this.id, this.name, this.email});

  factory UserModel.fromMap(map) {
    return UserModel(id: map['id'], name: map['Name'], email: map['Email']);
  }

  //sending data to firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Email': email,
      'Name': name,
    };
  }
}
