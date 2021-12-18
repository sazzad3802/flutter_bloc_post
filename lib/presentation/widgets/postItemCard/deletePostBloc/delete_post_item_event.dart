part of 'delete_post_item_bloc.dart';

abstract class DeletePostItemEvent extends Equatable {
  const DeletePostItemEvent();
}

class DeletePostLoading extends DeletePostItemEvent {
  @override
  List<Object?> get props => [];
}

class DeletePost extends DeletePostItemEvent {
  int postId;

  DeletePost({required this.postId});

  @override
  List<Object?> get props => [];
}
