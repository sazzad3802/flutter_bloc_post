import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  String? title;
  bool? backButton;

  MyAppbar({
    Key? key,
    this.title,
    this.backButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar(
        automaticallyImplyLeading: backButton!,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: Transform.translate(
          offset: Offset(backButton! ? -20 : 0, 0),
          child: Text(
            title!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      );

  @override
  Size get preferredSize => Size.fromHeight(55.0);
}
