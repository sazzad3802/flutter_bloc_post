import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_sazzad/presentation/screens/postDetail/sendCommentBloc/send_comment_bloc.dart';

class SendCommentWidget extends StatelessWidget {
  final int postId;
  final Function onReload;
  TextEditingController? commentController;

  SendCommentWidget({Key? key, required this.postId, required this.onReload})
      : super(key: key) {
    commentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var sendCommentBloc = BlocProvider.of<SendCommentBloc>(context);
    sendCommentBloc.stream.listen((state) {
      if (state is SendCommentSuccessState) {
        commentController = TextEditingController();
        onReload(true);
      }
    });
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Flexible(
            flex: 92,
            child: Container(
              padding: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.3,
                  color: Colors.black.withOpacity(0.3),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 14,
                  letterSpacing: 1,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                controller: commentController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write your comment',
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
                cursorHeight: 25,
                cursorWidth: 2,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Flexible(
              flex: 8,
              child: BlocBuilder<SendCommentBloc, SendCommentState>(
                builder: (context, state) {
                  if (state is SendCommentLoadingState) {
                    sendCommentBloc.add(SendComment(
                        comment: commentController!.text, postId: postId));
                    return const Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return InkWell(
                      onTap: () async =>
                          sendCommentBloc.add(SendCommentLoading()),
                      child: const Icon(
                        Icons.send,
                        size: 30,
                        color: Colors.deepPurple,
                      ),
                    );
                  }
                },
              )),
        ],
      ),
    );
  }
}
