import 'package:flutter_test_sazzad/data/model/comment.dart';

class SendCommentApiResponse {
  Comment? comment;

  SendCommentApiResponse({this.comment});

  SendCommentApiResponse.fromJson(Map<String, dynamic> json) {
    comment = json['data'] != null ? Comment.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (comment != null) {
      data['data'] = comment!.toJson();
    }
    return data;
  }
}
