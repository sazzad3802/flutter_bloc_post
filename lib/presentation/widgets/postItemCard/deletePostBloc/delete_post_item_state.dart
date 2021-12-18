part of 'delete_post_item_bloc.dart';

abstract class DeletePostItemState extends Equatable {
  const DeletePostItemState();
}

class DeletePostInitialState extends DeletePostItemState {
  @override
  List<Object> get props => [];
}

class DeletePostLoadingState extends DeletePostItemState {
  @override
  List<Object> get props => [];
}

class DeletePostSuccessState extends DeletePostItemState {
  final String message;

  const DeletePostSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class DeletePostErrorState extends DeletePostItemState {
  final String message;

  const DeletePostErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
