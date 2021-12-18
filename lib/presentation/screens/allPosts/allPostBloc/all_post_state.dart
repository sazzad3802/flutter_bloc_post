part of 'all_post_bloc.dart';

abstract class AllPostState extends Equatable {
  const AllPostState();
}

class FetchAllPostLoadingState extends AllPostState {
  @override
  List<Object?> get props => [];
}

class FetchAllPostSuccessState extends AllPostState {
  final List<Post> posts;

  const FetchAllPostSuccessState(this.posts);

  @override
  List<Object?> get props => [posts];
}

class FetchAllPostErrorState extends AllPostState {
  final String message;

  const FetchAllPostErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class GoToPostDetailState extends AllPostState {
  final Post postItem;

  const GoToPostDetailState({required this.postItem});
  @override
  // TODO: implement props
  List<Object?> get props => [postItem];
}
