import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final String errMsg1;
  final String? errMsg2;
  final double height;
  final double? width;
  const EmptyStateWidget(
      {Key? key,
      required this.errMsg1,
      this.errMsg2,
      required this.height,
      this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "img/empty.png",
              height: height * 0.6,
              width: width,
            ),
            const SizedBox(height: 20),
            Text(
              errMsg1,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              errMsg2!,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
