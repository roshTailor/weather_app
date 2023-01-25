import 'package:flutter/material.dart';

Widget textButton({required String name}) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      width: 80,
      height: 30,
      alignment: Alignment.center,
      child: Text(
        name,
        style: const TextStyle(
          fontSize: 18,
          letterSpacing: 1,
        ),
      ),
    ),
  );
}
