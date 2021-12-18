import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test_sazzad/config/app_locator.dart';
import 'package:flutter_test_sazzad/domain/repository/post_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'delete_post_item_event.dart';
part 'delete_post_item_state.dart';

class DeletePostItemBloc
    extends Bloc<DeletePostItemEvent, DeletePostItemState> {
  final PostRepository postRepository = di<PostRepository>();

  DeletePostItemBloc() : super(DeletePostInitialState());

  @override
  Stream<DeletePostItemState> mapEventToState(
      DeletePostItemEvent event) async* {
    if (event is DeletePost) {
      String message = await postRepository.deletePost(id: event.postId);
      if (message.isNotEmpty) {
        Fluttertoast.showToast(msg: message);
        yield DeletePostSuccessState(message);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong! please try again');
        yield const DeletePostErrorState(
            'Something went wrong! please try again');
      }
    } else if (event is DeletePostLoading) {
      yield DeletePostLoadingState();
    }
  }
}
