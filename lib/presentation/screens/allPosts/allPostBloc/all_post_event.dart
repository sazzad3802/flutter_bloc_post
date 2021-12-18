part of 'all_post_bloc.dart';

abstract class AllPostEvent extends Equatable {
  const AllPostEvent();
}

class AllPostLoading extends AllPostEvent {
  @override
  List<Object?> get props => [];
}

class FetchAllPost extends AllPostEvent {
  @override
  List<Object?> get props => [];
}

class ReloadAllPost extends AllPostEvent {
  @override
  List<Object?> get props => [];
}

class NavigateToPostDetail extends AllPostEvent {
  Post postItem;

  NavigateToPostDetail({required this.postItem});

  @override
  List<Object?> get props => [postItem];
}
