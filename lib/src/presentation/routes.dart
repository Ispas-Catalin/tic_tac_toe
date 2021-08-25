import 'package:flutter/material.dart';
import 'package:tic_tac_toe/main.dart';
import 'package:tic_tac_toe/src/presentation/multiplayer.dart';
import 'package:tic_tac_toe/src/presentation/single_player.dart';

// ignore: avoid_classes_with_only_static_members
class AppRoutes {
  static const String home = '/home';
  static const String singlePlayer = '/singlePlayer';
  static const String multiPlayer = '/multiplayer';

  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    home: (BuildContext context) => HomePage(),
    singlePlayer: (BuildContext context) => SinglePlayer(),
    multiPlayer: (BuildContext context) => Multiplayer(),
  };
}