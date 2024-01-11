import 'package:flutter/material.dart';

class OR extends StatelessWidget {
  const OR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Expanded(
        child: Divider(
          color: Color.fromRGBO(230, 230, 230, 1),
          thickness: 1,
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'OR',
          style: TextStyle(
            color: Color.fromRGBO(230, 230, 230, 1),
            fontSize: 14,
            fontFamily: 'openSans',
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      Expanded(
        child: Divider(
          color: Color.fromRGBO(230, 230, 230, 1),
          thickness: 1,
        ),
      ),
    ]);
  }
}
