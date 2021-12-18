part of 'post_detail_bloc.dart';

@immutable
abstract class PostDetailEvent extends Equatable {
  const PostDetailEvent();
}

class PostDetailLoading extends PostDetailEvent {
  @override
  List<Object?> get props => [];
}

class FetchPostDetail extends PostDetailEvent {
  int postId;

  FetchPostDetail({required this.postId});

  @override
  List<Object?> get props => [];
}
