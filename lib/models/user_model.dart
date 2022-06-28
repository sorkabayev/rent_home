class UserModel {
  String? id;
  String? fullName;
  String? password;
  String? phoneNumber;
  String? role;
  String? email;

  UserModel({
    this.id,
    this.fullName,
    this.password,
    this.phoneNumber,
    this.role,
    this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        fullName: json["fullName"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        role: json["role"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "password": password,
        "phoneNumber": phoneNumber,
        "role": role,
        "email": email,
      };

  @override
  String toString() {
    return "id: $id, role: $role, fullName $fullName, password: $password, phoneNumber: $phoneNumber, email: $email";
  }
}
