class LoginResponseModel {
  bool? success;
  String? msg;
  String? token;
  String? name;
  String? mobile;
  String? status;

  LoginResponseModel(
      {this.success,
      this.msg,
      this.token,
      this.name,
      this.mobile,
      this.status});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    token = json['token'];
    name = json['name'];
    mobile = json['mobile'];
    status = json['user_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['msg'] = msg;
    data['token'] = token;
    data['name'] = name;
    data['mobile'] = mobile;
    return data;
  }

  @override
  String toString() {
    return 'LoginResponseModel{success: $success, msg: $msg, token: $token, name: $name, mobile: $mobile, status: $status}';
  }
}
