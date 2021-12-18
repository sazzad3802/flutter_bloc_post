import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test_sazzad/config/app_locator.dart';
import 'package:flutter_test_sazzad/data/local/create_post_model.dart';
import 'package:flutter_test_sazzad/data/model/post.dart';
import 'package:flutter_test_sazzad/domain/repository/post_repository.dart';
import 'package:flutter_test_sazzad/enum/task_type.enum.dart';
import 'package:flutter_test_sazzad/utils/constant.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final PostRepository postRepository = di<PostRepository>();

  CreatePostBloc() : super(CreatePostInitialState());

  @override
  Stream<CreatePostState> mapEventToState(CreatePostEvent event) async* {
    if (event is CreateOrUpdatePost) {
      if (validate(event)) {
        Post _post = event.taskTypeEnum == TaskTypeEnum.create
            ? await postRepository.createPost(
                model: CreatePostModel(
                    title: event.title, description: event.desc),
              )
            : await postRepository.updatePost(
                id: event.postId!,
                model: CreatePostModel(
                    title: event.title, description: event.desc),
              );
        if (_post.id != null) {
          Fluttertoast.showToast(
              msg:
                  'Post ${event.taskTypeEnum.toString().split('.').last}d successfully!');
          yield CreatePostSuccessState();
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong, Please try again!');
          yield const CreatePostErrorState(
              'Something went wrong, Please try again!');
        }
      } else {
        yield CreatePostInitialState();
      }
    } else if (event is CreateOrUpdatePostLoading) {
      yield CreatePostLoadingState();
    }
  }

  bool validate(CreateOrUpdatePost event) {
    bool isValid = true;
    if (event.title.isEmpty) {
      Fluttertoast.showToast(msg: Constant.titleEmptyMessage);
      return false;
    }
    if (event.title.length < 3) {
      Fluttertoast.showToast(msg: Constant.titleErrorMessage);
      return false;
    }
    if (event.desc.isEmpty) {
      Fluttertoast.showToast(msg: Constant.descriptionEmptyMessage);
      return false;
    }
    if (event.desc.length < 10) {
      Fluttertoast.showToast(msg: Constant.descriptionErrorMessage);
      return false;
    }
    return isValid;
  }
}
