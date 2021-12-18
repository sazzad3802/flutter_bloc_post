import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test_sazzad/config/app_locator.dart';
import 'package:flutter_test_sazzad/data/model/comment.dart';
import 'package:flutter_test_sazzad/domain/repository/post_repository.dart';
import 'package:flutter_test_sazzad/utils/constant.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'send_comment_event.dart';
part 'send_comment_state.dart';

class SendCommentBloc extends Bloc<SendCommentEvent, SendCommentState> {
  final PostRepository postRepository = di<PostRepository>();

  SendCommentBloc() : super(SendCommentInitial());

  @override
  Stream<SendCommentState> mapEventToState(SendCommentEvent event) async* {
    if (event is SendComment) {
      if (validate(event)) {
        Comment _comment = await postRepository.createComment(
            comment: event.comment, postId: event.postId);
        if (_comment.id != null) {
          yield SendCommentSuccessState(_comment);
        } else {
          yield const SendCommentErrorState(
              'Something went wrong! Please try again');
        }
      } else {
        yield const SendCommentErrorState(
            'Something went wrong! Please try again');
      }
    } else if (event is SendCommentLoading) {
      yield SendCommentLoadingState();
    }
  }

  bool validate(SendComment event) {
    bool isValid = true;
    if (event.comment.isEmpty) {
      Fluttertoast.showToast(msg: Constant.commentEmptyMessage);
      return false;
    }
    if (event.comment.length < 3) {
      Fluttertoast.showToast(msg: Constant.commentErrorMessage);
      return false;
    }
    return isValid;
  }
}
