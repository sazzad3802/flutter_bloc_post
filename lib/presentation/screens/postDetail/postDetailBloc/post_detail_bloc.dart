import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test_sazzad/config/app_locator.dart';
import 'package:flutter_test_sazzad/data/model/post.dart';
import 'package:flutter_test_sazzad/domain/repository/post_repository.dart';
import 'package:meta/meta.dart';

part 'post_detail_event.dart';
part 'post_detail_state.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  final PostRepository postRepository = di<PostRepository>();
  Post _post = Post();

  PostDetailBloc() : super(FetchPostDetailLoadingState());

  @override
  Stream<PostDetailState> mapEventToState(PostDetailEvent event) async* {
    if (event is FetchPostDetail) {
      _post = await postRepository.getPostDetail(postId: event.postId);
      yield PostDetailSuccessState(_post);
    } else if (event is PostDetailLoading) {
      yield FetchPostDetailLoadingState();
    }
  }
}
