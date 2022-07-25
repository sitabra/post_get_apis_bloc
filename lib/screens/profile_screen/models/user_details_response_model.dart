class UserDetailsResponseModel {
  String? id;
  int? iD;
  String? name;
  String? email;
  String? profilepicture;
  String? location;
  String? createdat;

  UserDetailsResponseModel(
      {this.id,
        this.iD,
        this.name,
        this.email,
        this.profilepicture,
        this.location,
        this.createdat});

  UserDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['$id'];
    iD = json['id'];
    name = json['name'];
    email = json['email'];
    profilepicture = json['profilepicture'];
    location = json['location'];
    createdat = json['createdat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['$id'] = id;
    data['id'] = iD;
    data['name'] = name;
    data['email'] = email;
    data['profilepicture'] = profilepicture;
    data['location'] = location;
    data['createdat'] = createdat;
    return data;
  }
}
