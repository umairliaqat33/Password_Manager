class CredentialUserModel {
  String? email;
  String? userName;
  String? id;

  CredentialUserModel({this.userName, this.email, this.id});

  factory CredentialUserModel.fromMap(map) {
    return CredentialUserModel(
        userName: map['userName'], email: map['email'], id: map['id']);
  }

  Map<String, dynamic> toMap() {
    return {'userName': userName, 'email': email, 'id': id};
  }
}
