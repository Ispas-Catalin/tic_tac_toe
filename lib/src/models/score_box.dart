import 'package:flutter/material.dart';

Container scoreBox(String url) {
  return Container(
    height: 120,
    width: 120,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.indigo,
      border: Border.all(color: Colors.blue.shade900, width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.black,
          blurRadius: 2.0,
          spreadRadius: 0.0,
          offset: Offset(1.0, 2.0), // shadow direction: bottom right
        )
      ],
    ),
    child: Center(
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage('$url'),
            fit: BoxFit.contain,
          ),
        ),
      ),
    ),
  );
}
