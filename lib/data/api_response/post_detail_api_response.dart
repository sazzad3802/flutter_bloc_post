import 'package:flutter_test_sazzad/data/model/post.dart';

class PostDetailApiResponse {
  Post? post;

  PostDetailApiResponse({this.post});

  PostDetailApiResponse.fromJson(Map<String, dynamic> json) {
    post = json['data'] != null ? Post.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (post != null) {
      data['data'] = post!.toJson();
    }
    return data;
  }
}
