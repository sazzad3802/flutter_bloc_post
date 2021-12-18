part of 'create_post_bloc.dart';

abstract class CreatePostEvent extends Equatable {
  const CreatePostEvent();
}

class CreateOrUpdatePostLoading extends CreatePostEvent {
  @override
  List<Object?> get props => [];
}

class CreateOrUpdatePost extends CreatePostEvent {
  String title;
  String desc;
  TaskTypeEnum taskTypeEnum;
  int? postId;

  CreateOrUpdatePost(
      {required this.title,
      required this.desc,
      required this.taskTypeEnum,
      this.postId});

  @override
  List<Object?> get props => [title, desc, taskTypeEnum, postId];
}
