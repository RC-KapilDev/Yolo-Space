import 'package:flutter/material.dart';

class DividerLine extends StatelessWidget {
  const DividerLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: const Divider(
        thickness: 0.9,
        color: Color.fromARGB(255, 24, 24, 23),
      ),
    );
  }
}
