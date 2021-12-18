part of 'create_post_bloc.dart';

abstract class CreatePostState extends Equatable {
  const CreatePostState();
}

class CreatePostInitialState extends CreatePostState {
  @override
  List<Object> get props => [];
}

class CreatePostLoadingState extends CreatePostState {
  @override
  List<Object?> get props => [];
}

class CreatePostSuccessState extends CreatePostState {
  @override
  List<Object?> get props => [];
}

class CreatePostErrorState extends CreatePostState {
  final String message;

  const CreatePostErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
