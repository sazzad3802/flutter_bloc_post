import 'package:flutter_test_sazzad/data/model/post.dart';

class AllPostApiResponse {
  List<Post>? postList;

  AllPostApiResponse({this.postList});

  AllPostApiResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      postList = <Post>[];
      json['data'].forEach((v) {
        postList!.add(Post.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (postList != null) {
      data['data'] = postList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
