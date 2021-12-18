part of 'post_detail_bloc.dart';

@immutable
abstract class PostDetailState extends Equatable {
  const PostDetailState();
}

class PostDetailInitial extends PostDetailState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchPostDetailLoadingState extends PostDetailState {
  @override
  List<Object?> get props => [];
}

class PostDetailSuccessState extends PostDetailState {
  final Post post;

  const PostDetailSuccessState(this.post);

  @override
  List<Object?> get props => [post];
}

class PostDetailErrorState extends PostDetailState {
  final String message;

  const PostDetailErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
