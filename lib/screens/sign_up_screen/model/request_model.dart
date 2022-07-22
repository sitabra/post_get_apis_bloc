class RegistrationRequestModel {
  String? name;
  String? email;
  String? password;

  RegistrationRequestModel(this.name, this.email, this.password);

  RegistrationRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
