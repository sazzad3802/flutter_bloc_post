import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_sazzad/config/app_locator.dart' as di;
import 'package:flutter_test_sazzad/presentation/screens/allPosts/allPostBloc/all_post_bloc.dart';
import 'package:flutter_test_sazzad/presentation/screens/allPosts/all_post.screen.dart';
import 'package:flutter_test_sazzad/presentation/screens/postDetail/sendCommentBloc/send_comment_bloc.dart';
import 'package:flutter_test_sazzad/presentation/widgets/createPostForm/createPostBloc/create_post_bloc.dart';
import 'package:flutter_test_sazzad/presentation/widgets/postItemCard/deletePostBloc/delete_post_item_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AllPostBloc()),
        BlocProvider(create: (BuildContext context) => CreatePostBloc()),
        BlocProvider(create: (BuildContext context) => SendCommentBloc()),
      ],
      child: FlutterTestApp(),
    ),
  );
}

class FlutterTestApp extends StatelessWidget {
  const FlutterTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // primaryColor: Color(0xffE7014C),
        backgroundColor: Colors.white,
      ),
      title: "Flutter Test",
      // onGenerateRoute: AppRouter.generateRoute,
      // initialRoute: RoutePath.allPosts,
      home: AllPostScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
