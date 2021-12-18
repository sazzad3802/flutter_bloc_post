import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_sazzad/data/model/post.dart';
import 'package:flutter_test_sazzad/enum/task_type.enum.dart';
import 'package:flutter_test_sazzad/presentation/widgets/createPostForm/create_post_form.widget.dart';
import 'package:flutter_test_sazzad/presentation/widgets/postItemCard/deletePostBloc/delete_post_item_bloc.dart';

class PostItemCardWidget extends StatelessWidget {
  final Post postItem;
  final Function? onReload;

  const PostItemCardWidget({Key? key, required this.postItem, this.onReload})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deletePostBloc = BlocProvider.of<DeletePostItemBloc>(context);
    deletePostBloc.stream.listen((state) {
      if (state is DeletePostSuccessState) {
        onReload!(true);
      }
    });
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.1,
          color: Colors.deepPurple.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.1),
            offset: const Offset(
              1.0,
              5.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
          const BoxShadow(
            color: Colors.white,
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Image.asset(
                      "img/user.png",
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          postItem.createdUser!.name!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Text(
                              'yesterday',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              '.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                            const SizedBox(width: 3),
                            Icon(
                              Icons.vpn_lock,
                              size: 15,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    postItem.title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    postItem.description!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 0.5,
                  color: Colors.black.withOpacity(0.2),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      alignment: Alignment.center,
                      child:
                          BlocBuilder<DeletePostItemBloc, DeletePostItemState>(
                        builder: (context, state) {
                          if (state is DeletePostLoadingState) {
                            deletePostBloc
                                .add(DeletePost(postId: postItem.id!));
                            return const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2.5));
                          } else {
                            return InkWell(
                              onTap: () {
                                deletePostBloc.add(DeletePostLoading());
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.delete_outline,
                                      size: 16,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Delete',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      width: MediaQuery.of(context).size.width * 0.45,
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => CreatePostFormWidget(
                              taskTypeEnum: TaskTypeEnum.update,
                              title: postItem.title,
                              desc: postItem.description,
                              postId: postItem.id,
                              onReload: onReload,
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit,
                              size: 16,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Update',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
