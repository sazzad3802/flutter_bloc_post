import 'package:flutter_test_sazzad/data/model/comment.dart';
import 'package:flutter_test_sazzad/data/model/created_user.dart';

class Post {
  int? id;
  String? title;
  String? description;
  List<Comment>? commentList;
  CreatedUser? createdUser;

  Post(
      {this.id,
      this.title,
      this.description,
      this.commentList,
      this.createdUser});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    if (json['comments'] != null) {
      commentList = <Comment>[];
      json['comments'].forEach((v) {
        commentList!.add(Comment.fromJson(v));
      });
    }
    createdUser = json['created_user'] != null
        ? CreatedUser.fromJson(json['created_user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    if (createdUser != null) {
      data['created_user'] = createdUser!.toJson();
    }
    return data;
  }
}
