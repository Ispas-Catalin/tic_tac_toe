import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/presentation/routes.dart';

void main() {
  runApp(const TicTacToe());
}

class TicTacToe extends StatelessWidget {
  const TicTacToe({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: AppRoutes.routes,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  static const double _cardPadding = 8;
  static const double _cardFontSize = 32;

  @override
  void initState() {
    super.initState();
    loadingScreenTimer();
  }

  Future<void> loadingScreenTimer() async {
    setState(() {
      _isLoading = true;
    });
    Timer(const Duration(seconds: 5), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            appBar: AppBar(title: const Text('Tic Tac Toe')),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.singlePlayer);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(_cardPadding),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 1.618,
                    child: const Card(
                      elevation: 16,
                      child: Center(
                        child: Text(
                          'Single Player',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: _cardFontSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.multiPlayer);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(_cardPadding),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 1.618,
                    child: const Card(
                      elevation: 16,
                      child: Center(
                        child: Text(
                          'Multiplayer',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: _cardFontSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
