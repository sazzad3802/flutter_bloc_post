import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_sazzad/enum/task_type.enum.dart';
import 'package:flutter_test_sazzad/presentation/widgets/createPostForm/createPostBloc/create_post_bloc.dart';

class CreatePostFormWidget extends StatelessWidget {
  final Function? onReload;
  TaskTypeEnum taskTypeEnum;
  String? title;
  String? desc;
  int? postId;
  TextEditingController? titleController;
  TextEditingController? descController;

  CreatePostFormWidget(
      {Key? key,
      this.onReload,
      required this.taskTypeEnum,
      this.title,
      this.postId,
      this.desc})
      : super(key: key) {
    if (taskTypeEnum == TaskTypeEnum.create) {
      titleController = TextEditingController();
      descController = TextEditingController();
    } else {
      titleController = TextEditingController(text: title!);
      descController = TextEditingController(text: desc!);
    }
  }

  @override
  Widget build(BuildContext context) {
    var createPostBloc = BlocProvider.of<CreatePostBloc>(context);
    createPostBloc.stream.listen((state) {
      if (state is CreatePostSuccessState) {
        Navigator.pop(context);
        onReload!(true);
      }
    });
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        insetPadding: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 30),
                    child: Text(
                      taskTypeEnum == TaskTypeEnum.create
                          ? 'Create New Post'
                          : 'Update post',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async => Navigator.pop(context),
                    child: Container(
                      margin: const EdgeInsets.only(right: 10, bottom: 20),
                      child: Transform.rotate(
                        angle: -math.pi / 4,
                        child: const Icon(
                          Icons.add_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.3,
                    color: Colors.black.withOpacity(0.3),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: TextField(
                  style: const TextStyle(
                    fontSize: 15,
                    letterSpacing: 1,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter post title',
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  cursorColor: Theme.of(context).primaryColor,
                  cursorHeight: 25,
                  cursorWidth: 2,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.3,
                    color: Colors.black.withOpacity(0.3),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: TextField(
                  style: const TextStyle(
                    fontSize: 15,
                    letterSpacing: 1,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                  controller: descController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter post description',
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  cursorColor: Theme.of(context).primaryColor,
                  cursorHeight: 25,
                  cursorWidth: 2,
                ),
              ),
              BlocBuilder<CreatePostBloc, CreatePostState>(
                builder: (context, state) {
                  if (state is CreatePostLoadingState) {
                    createPostBloc.add(CreateOrUpdatePost(
                      title: titleController!.text,
                      desc: descController!.text,
                      taskTypeEnum: taskTypeEnum,
                      postId: postId,
                    ));
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: const SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(strokeWidth: 3),
                      ),
                    );
                  } else {
                    return InkWell(
                      onTap: () {
                        createPostBloc.add(CreateOrUpdatePostLoading());
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Text(
                          taskTypeEnum == TaskTypeEnum.create
                              ? 'Create'
                              : 'Update',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
