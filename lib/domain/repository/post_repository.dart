import 'package:flutter_test_sazzad/config/app_locator.dart';
import 'package:flutter_test_sazzad/data/api_response/all_post_api_response.dart';
import 'package:flutter_test_sazzad/data/api_response/create_post_api_response.dart';
import 'package:flutter_test_sazzad/data/api_response/delete_post_api_response.dart';
import 'package:flutter_test_sazzad/data/api_response/post_detail_api_response.dart';
import 'package:flutter_test_sazzad/data/api_response/send_comment_api_response.dart';
import 'package:flutter_test_sazzad/data/local/create_post_model.dart';
import 'package:flutter_test_sazzad/data/model/comment.dart';
import 'package:flutter_test_sazzad/data/model/post.dart';
import 'package:flutter_test_sazzad/domain/service/post_api_service.dart';

class PostRepository {
  final PostApiService postApiService = di<PostApiService>();

  Future<List<Post>> getAllPost() async {
    List<Post> post = [];
    try {
      var response = await postApiService.fetchAllPost();
      post = AllPostApiResponse.fromJson(response.data).postList!;
    } catch (e) {
      print(e);
    }
    return post;
  }

  Future<Post> getPostDetail({required int postId}) async {
    Post post = Post();
    try {
      var response = await postApiService.fetchPostDetail(postId: postId);
      post = PostDetailApiResponse.fromJson(response.data).post!;
    } catch (e) {
      print(e);
    }
    return post;
  }

  Future<Post> createPost({required CreatePostModel model}) async {
    Post post = Post();
    try {
      var response = await postApiService.createPost(model: model);
      post = CreatePostApiResponse.fromJson(response.data).post!;
    } catch (e) {
      print(e);
    }
    return post;
  }

  Future<String> deletePost({required int id}) async {
    String successMessage = '';
    var response = await postApiService.deletePost(id: id);
    try {
      successMessage = DeletePostApiResponse.fromJson(response.data).message!;
    } catch (e) {
      print(e);
    }
    return successMessage;
  }

  Future<Post> updatePost(
      {required int id, required CreatePostModel model}) async {
    Post post = Post();
    var response = await postApiService.updatePost(id: id, model: model);
    try {
      post = CreatePostApiResponse.fromJson(response.data).post!;
    } catch (e) {
      print(e);
    }
    return post;
  }

  Future<Comment> createComment(
      {required String comment, required int postId}) async {
    Comment _comment = Comment();
    try {
      var response =
          await postApiService.createComment(comment: comment, postId: postId);
      _comment = SendCommentApiResponse.fromJson(response.data).comment!;
    } catch (e) {
      print(e);
    }
    return _comment;
  }
}
