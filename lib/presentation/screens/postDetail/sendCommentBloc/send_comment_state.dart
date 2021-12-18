part of 'send_comment_bloc.dart';

abstract class SendCommentState extends Equatable {
  const SendCommentState();
}

class SendCommentInitial extends SendCommentState {
  @override
  List<Object> get props => [];
}

class SendCommentLoadingState extends SendCommentState {
  @override
  List<Object?> get props => [];
}

class SendCommentSuccessState extends SendCommentState {
  final Comment comment;

  const SendCommentSuccessState(this.comment);

  @override
  List<Object?> get props => [comment];
}

class SendCommentErrorState extends SendCommentState {
  final String message;

  const SendCommentErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
