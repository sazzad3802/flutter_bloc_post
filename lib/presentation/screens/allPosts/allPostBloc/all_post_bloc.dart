import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test_sazzad/config/app_locator.dart';
import 'package:flutter_test_sazzad/data/model/post.dart';
import 'package:flutter_test_sazzad/domain/repository/post_repository.dart';

part 'all_post_event.dart';
part 'all_post_state.dart';

class AllPostBloc extends Bloc<AllPostEvent, AllPostState> {
  final PostRepository postRepository = di<PostRepository>();

  List<Post> _postList = [];
  AllPostBloc() : super(FetchAllPostLoadingState());

  @override
  Stream<AllPostState> mapEventToState(AllPostEvent event) async* {
    if (event is FetchAllPost) {
      _postList =
          _postList.isEmpty ? await postRepository.getAllPost() : _postList;
      yield FetchAllPostSuccessState(_postList);
    } else if (event is ReloadAllPost) {
      _postList = await postRepository.getAllPost();
      yield FetchAllPostSuccessState(_postList);
    } else if (event is AllPostLoading) {
      yield FetchAllPostLoadingState();
    } else if (event is NavigateToPostDetail) {
      yield GoToPostDetailState(postItem: event.postItem);
    }
  }
}
