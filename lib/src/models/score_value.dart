import 'package:flutter/material.dart';

Container scoreValue(int score) {
  return Container(
    height: 42,
    width: 42,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.black26.withOpacity(0.5),
      border: Border.all(color: Colors.blue.shade900, width: 2),
    ),
    child: Center(
      child: Text(
        '$score',
        style: const TextStyle(
          fontSize: 24,
          color: Colors.white70,
        ),
      ),
    ),
  );
}
