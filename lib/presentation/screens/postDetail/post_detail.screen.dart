import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_sazzad/data/model/post.dart';
import 'package:flutter_test_sazzad/presentation/screens/postDetail/postDetailBloc/post_detail_bloc.dart';
import 'package:flutter_test_sazzad/presentation/screens/postDetail/send_comment.widget.dart';
import 'package:flutter_test_sazzad/presentation/widgets/app_bar.widget.dart';

class PostDetailScreen extends StatelessWidget {
  final int postId;

  const PostDetailScreen({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var postDetailBloc = BlocProvider.of<PostDetailBloc>(context);

    Future<void> onReload(bool isCommentAdded) async {
      if (isCommentAdded) {
        postDetailBloc.add(FetchPostDetail(postId: postId));
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppbar(title: 'Post Detail', backButton: true),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            postDetailBloc.add(FetchPostDetail(postId: postId));
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: BlocBuilder<PostDetailBloc, PostDetailState>(
              builder: (context, state) {
                if (state is FetchPostDetailLoadingState) {
                  postDetailBloc.add(FetchPostDetail(postId: postId));
                  return const Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is PostDetailSuccessState) {
                  Post post = state.post;
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                    post.createdUser!.name!,
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
                              post.title!,
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
                              post.description!,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                          Row(
                            children: [
                              Icon(
                                Icons.comment,
                                size: 20,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Comments',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          state.post.commentList!.isNotEmpty
                              ? Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      var commentItem =
                                          state.post.commentList![index];
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "img/user.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(width: 10),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 8,
                                                horizontal: 12,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    commentItem
                                                        .createdUser!.name!,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.deepPurple,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                    child: Text(
                                                      commentItem.message!,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: state.post.commentList!.length,
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(height: 20),
                          SendCommentWidget(
                            postId: postId,
                            onReload: onReload,
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
