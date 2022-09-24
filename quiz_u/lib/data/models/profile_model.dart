class ProfileModel {
  String? name;
  String? mobile;

  ProfileModel({this.name, this.mobile});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['mobile'] = mobile;
    return data;
  }
}
