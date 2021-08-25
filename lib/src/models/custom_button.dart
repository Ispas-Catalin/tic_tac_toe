import 'package:flutter/material.dart';

Container customButton(String text) {
  return Container(
    decoration: const BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      color: Colors.indigo,
      boxShadow: [
        BoxShadow(
          color: Colors.black,
          blurRadius: 2.0,
          spreadRadius: 0.0,
          offset: Offset(2.0, 2.0), // shadow direction: bottom right
        )
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: Text(
        '$text',
        style: const TextStyle(
          fontSize: 24,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
