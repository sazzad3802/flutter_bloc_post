import 'package:flutter_test_sazzad/data/model/created_user.dart';

class Comment {
  int? id;
  String? message;
  CreatedUser? createdUser;

  Comment({this.id, this.message, this.createdUser});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    createdUser = json['created_user'] != null
        ? CreatedUser.fromJson(json['created_user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    if (createdUser != null) {
      data['created_user'] = createdUser!.toJson();
    }
    return data;
  }
}
