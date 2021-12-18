// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test_sazzad/presentation/bloc/postDetail/post_detail_bloc.dart';
// import 'package:flutter_test_sazzad/presentation/screens/all_post.screen.dart';
// import 'package:flutter_test_sazzad/presentation/screens/post_detail.screen.dart';
// import 'package:flutter_test_sazzad/utils/router.dart';
//
// class AppRouter {
//   static Route<dynamic> generateRoute(RouteSettings routeSettings) {
//     switch (routeSettings.name) {
//       case RoutePath.allPosts:
//         {
//           return MaterialPageRoute(
//             builder: (_) => const AllPostScreen(),
//           );
//         }
//       case RoutePath.postDetail:
//         {
//           return MaterialPageRoute(
//             builder: (_) {
//               return BlocProvider(
//                 create: (_) => PostDetailBloc(),
//                 child: PostDetailScreen(),
//               );
//             },
//           );
//         }
//       default:
//         {
//           return MaterialPageRoute(
//             builder: (_) => Scaffold(
//               body: Center(
//                 child: Text("No route defined for ${routeSettings.name}"),
//               ),
//             ),
//           );
//         }
//     }
//   }
// }
