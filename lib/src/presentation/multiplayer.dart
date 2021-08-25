import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/models/custom_button.dart';
import 'package:tic_tac_toe/src/models/score_box.dart';
import 'package:tic_tac_toe/src/models/score_value.dart';

class Multiplayer extends StatefulWidget {
  const Multiplayer({Key key}) : super(key: key);

  @override
  _MultiplayerState createState() => _MultiplayerState();
}

const String _xImage = 'assets/images/X.jpg';
const String _oImage = 'assets/images/O.jpg';

class _MultiplayerState extends State<Multiplayer> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final bool value = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: const Text('Are you sure you want to exit?'),
                actions: <Widget>[
                  FlatButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  FlatButton(
                    child: const Text('Yes, exit'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            });
        return value == true;
      },
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.2, 0.7, 1],
              colors: [
                Colors.deepPurple,
                Colors.blueAccent,
                Colors.deepPurpleAccent
              ],
            ),
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 32),
              Row(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.width / 4,
                    child: Stack(
                      children: <Widget>[
                        scoreBox(_xImage),
                        Positioned(
                          left: 2,
                          top: 0,
                          child: scoreValue(_xScore),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: MediaQuery.of(context).size.width / 4,
                    child: Stack(
                      children: <Widget>[
                        scoreBox(_oImage),
                        Positioned(
                          right: 2,
                          top: 0,
                          child: scoreValue(_oScore),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width+16,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Timer(const Duration(milliseconds: 100), () {
                            setState(() {
                              if (_gameOk == true) {
                                playGame(index);
                              }
                            });
                          });
                        },
                        child: Card(
                          elevation: 4,
                          color: Colors.white.withOpacity(0.8),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: AnimatedOpacity(
                              opacity: _imageVisibility ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 400),
                              child: Image.asset(
                                '${gameImage[index]}',
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: AnimatedOpacity(
                        opacity: _announcementVisibility ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 400),
                        child: Text(
                          '$_winText',
                          style: const TextStyle(fontSize: 38),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AnimatedOpacity(
                        opacity: _buttonsVisibility ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 400),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      resetGame();
                                    });
                                  },
                                  child: customButton('Reset'),
                                ),
                              ),
                              const Expanded(
                                child: SizedBox(),
                                flex: 1,
                              ),
                              Expanded(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      playAgain();
                                    });
                                  },
                                  child: customButton('Play again'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  int _xScore = 0, _oScore = 0;
  bool _buttonsVisibility = false,
      _announcementVisibility = false,
      _imageVisibility = true;
  String _winText = 'X Won!';
  static const String _empty = 'assets/images/game_assets/transparent.jpg',
      _X = _xImage,
      _O = _oImage,
      _xWon = 'X won!',
      _oWon = 'O won!';
  int _counter = 0;

  bool _gameOk = true;

  bool _winner, _winnerOk;

  List<String> gameImage = [
    'assets/images/transparent.jpg',
    'assets/images/transparent.jpg',
    'assets/images/transparent.jpg',
    'assets/images/transparent.jpg',
    'assets/images/transparent.jpg',
    'assets/images/transparent.jpg',
    'assets/images/transparent.jpg',
    'assets/images/transparent.jpg',
    'assets/images/transparent.jpg',
  ];

  List<int> gameStage = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];

  void playGame(int index) {
    if (gameImage[index] == 'assets/images/transparent.jpg') {
      _counter++;
      gameImage[index] = getImage(_counter % 2);
      gameStage[index] = _counter % 2 + 10;
    }
    checkGame();
  }

  String getImage(int state) {
    if (state == 1) {
      return _X;
    }
    if (state == 0) {
      return _O;
    }
    return _empty;
  }

  void checkGame() {
    // ignore: prefer_final_locals, always_specify_types
    List<int> check = [
      gameStage[0] + gameStage[4] + gameStage[8],
      gameStage[0] + gameStage[3] + gameStage[6],
      gameStage[1] + gameStage[4] + gameStage[7],
      gameStage[2] + gameStage[5] + gameStage[8],
      gameStage[2] + gameStage[4] + gameStage[6],
      gameStage[2] + gameStage[1] + gameStage[0],
      gameStage[5] + gameStage[4] + gameStage[3],
      gameStage[8] + gameStage[7] + gameStage[6],
    ];
    if (_counter == 9) {
      _gameOk = false;
      announceWinner(-1);
      _winnerOk = false;
    }
    for (int i = 0; i <= 7; i++) {
      if (check[i] == 30) {
        _gameOk = false;
        _winner = true;
        _winnerOk = true;
        announceWinner(i);
      }
      if (check[i] == 33) {
        _gameOk = false;
        _winner = false;
        _winnerOk = true;
        announceWinner(i);
      }
    }
  }

  Future<void> announceWinner(int animationType) async {
    Timer(
      const Duration(milliseconds: 800),
      () {
        if (animationType == -1) {
          _winText = 'Tie!';
        }

        if (_winnerOk == true) {
          _winnerOk = false;
          if (!_winner) {
            _xScore++;
            _winText = _xWon;
          } else {
            _oScore++;
            _winText = _oWon;
          }
        }
        setState(() {
          _announcementVisibility = true;
        });
      },
    );

    Timer(
      const Duration(milliseconds: 2000),
      () {
        setState(() {
          _buttonsVisibility = true;
        });
      },
    );
  }

  void resetGame() {
    _buttonsVisibility = false;
    _announcementVisibility = false;
    _imageVisibility = false;
    Timer(const Duration(milliseconds: 400), () {
      setState(() {
        // ignore: always_specify_types
        gameImage = [
          'assets/images/transparent.jpg',
          'assets/images/transparent.jpg',
          'assets/images/transparent.jpg',
          'assets/images/transparent.jpg',
          'assets/images/transparent.jpg',
          'assets/images/transparent.jpg',
          'assets/images/transparent.jpg',
          'assets/images/transparent.jpg',
          'assets/images/transparent.jpg',
        ];
        _imageVisibility = true;
      });
    });
    _counter = 0;
    // ignore: always_specify_types
    gameStage = [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ];
    _xScore = 0;
    _oScore = 0;
    _gameOk = true;
  }

  void playAgain() {
    _buttonsVisibility = false;
    _announcementVisibility = false;
    _imageVisibility = false;
    Timer(const Duration(milliseconds: 400), () {
      setState(() {
        // ignore: always_specify_types
        gameImage = [
          'assets/images/transparent.jpg',
          'assets/images/transparent.jpg',
          'assets/images/transparent.jpg',
          'assets/images/transparent.jpg',
          'assets/images/transparent.jpg',
          'assets/images/transparent.jpg',
          'assets/images/transparent.jpg',
          'assets/images/transparent.jpg',
          'assets/images/transparent.jpg',
        ];
        _imageVisibility = true;
      });
    });
    _counter = 0;
    // ignore: always_specify_types
    gameStage = [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ];
    _gameOk = true;
  }
}
