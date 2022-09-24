class TokenValidationResponseModel {
  bool? success;
  String? msg;

  TokenValidationResponseModel({this.success, this.msg});

  TokenValidationResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['succes'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['succes'] = success;
    data['msg'] = msg;
    return data;
  }

  @override
  String toString() {
    return 'TokenValidationResponseModel{success: $success, msg: $msg}';
  }
}