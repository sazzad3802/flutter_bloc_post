import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_sazzad/enum/task_type.enum.dart';
import 'package:flutter_test_sazzad/presentation/screens/allPosts/allPostBloc/all_post_bloc.dart';
import 'package:flutter_test_sazzad/presentation/screens/postDetail/postDetailBloc/post_detail_bloc.dart';
import 'package:flutter_test_sazzad/presentation/screens/postDetail/post_detail.screen.dart';
import 'package:flutter_test_sazzad/presentation/widgets/app_bar.widget.dart';
import 'package:flutter_test_sazzad/presentation/widgets/createPostForm/create_post_form.widget.dart';
import 'package:flutter_test_sazzad/presentation/widgets/empty_state.widget.dart';
import 'package:flutter_test_sazzad/presentation/widgets/postItemCard/deletePostBloc/delete_post_item_bloc.dart';
import 'package:flutter_test_sazzad/presentation/widgets/postItemCard/post_item_card.widget.dart';

class AllPostScreen extends StatelessWidget {

  // late AllPostBloc allPostBloc;
  const AllPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var allPostBloc = BlocProvider.of<AllPostBloc>(context);
    Future<void> onReload(bool isChanged) async {
      if (isChanged) {
        allPostBloc.add(ReloadAllPost());
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppbar(title: 'All Posts', backButton: false),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            allPostBloc.add(ReloadAllPost());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: BlocBuilder<AllPostBloc, AllPostState>(
                builder: (context, state) {
                  if (state is FetchAllPostLoadingState) {
                    allPostBloc.add(FetchAllPost());
                    return const Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is FetchAllPostSuccessState) {
                    if (state.posts.isEmpty) {
                      return const EmptyStateWidget(
                        errMsg1: 'No Posts found!',
                        errMsg2: 'to create new post press the (+) button',
                        height: 300,
                        width: 300,
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var postItem = state.posts[index];
                          return InkWell(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => PostDetailBloc(),
                                    child: PostDetailScreen(
                                      postId: state.posts[index].id!,
                                    ),),
                                ),
                              ).then((value) => allPostBloc.add(FetchAllPost()));
                            },
                            child: BlocProvider(
                              create: (context) => DeletePostItemBloc(),
                              child: PostItemCardWidget(
                                postItem: postItem,
                                onReload: onReload,
                              ),
                            ),
                          );
                        },
                        itemCount: state.posts.length,
                      );
                    }
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => CreatePostFormWidget(
              taskTypeEnum: TaskTypeEnum.create,
              onReload: onReload,
            ),
          );
        },
      ),
    );
  }
}
