class LogInResponseModel {
  String? id;
  int? code;
  String? message;
  Data? data;

  LogInResponseModel({this.id, this.code, this.message, this.data});

  LogInResponseModel.withError(String errorMsg){
    message = errorMsg;
  }

  LogInResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['$id'] = this.id;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  int? iD;
  String? name;
  String? email;
  String? token;

  Data({this.id, this.iD, this.name, this.email, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    iD = json['Id'];
    name = json['Name'];
    email = json['Email'];
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['$id'] = this.id;
    data['Id'] = this.iD;
    data['Name'] = this.name;
    data['Email'] = this.email;
    data['Token'] = this.token;
    return data;
  }
}
