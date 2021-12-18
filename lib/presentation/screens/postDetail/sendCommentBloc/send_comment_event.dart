part of 'send_comment_bloc.dart';

abstract class SendCommentEvent extends Equatable {
  const SendCommentEvent();
}

class SendCommentLoading extends SendCommentEvent {
  @override
  List<Object?> get props => [];
}

class SendComment extends SendCommentEvent {
  int postId;
  String comment;

  SendComment({required this.postId, required this.comment});

  @override
  List<Object?> get props => [];
}
