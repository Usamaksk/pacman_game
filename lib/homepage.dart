import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pacman_game/path.dart';
import 'package:pacman_game/pixel.dart';
import 'package:pacman_game/player.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static int numberInRow = 11;
  int numberofSqaures = numberInRow * 17;
  int player = numberInRow * 15 + 1;
  int ghost = -1;
  bool mouthClosed = false;
  int score = 0;
  bool preGame = true;

  List<int> barries = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    22,
    33,
    44,
    55,
    66,
    77,
    99,
    110,
    121,
    132,
    143,
    154,
    165,
    176,
    177,
    178,
    179,
    180,
    181,
    182,
    183,
    184,
    185,
    186,
    175,
    164,
    153,
    142,
    131,
    120,
    109,
    87,
    76,
    65,
    54,
    43,
    32,
    21,
    78,
    79,
    80,
    100,
    101,
    102,
    84,
    85,
    86,
    106,
    107,
    108,
    24,
    35,
    46,
    57,
    30,
    41,
    52,
    63,
    81,
    70,
    59,
    61,
    72,
    83,
    26,
    28,
    37,
    38,
    39,
    123,
    134,
    145,
    156,
    129,
    140,
    151,
    162,
    103,
    114,
    125,
    105,
    116,
    127,
    147,
    148,
    149,
    158,
    160
  ];

  List<int> food = [];

  void getFood() {
    for (int i = 0; i < numberofSqaures; i++) {
      if (!barries.contains(i)) {
        food.add(i);
      }
    }
  }

  String direction = "right";
  bool gameStarted = false;


  void startGame() {
    gameStarted = true;
    getFood();
    Timer.periodic(Duration(milliseconds: 120), (timer) {
     setState(() {
       mouthClosed = !mouthClosed;
     });
      if (food.contains(player)) {
        food.remove(player);
        score++;
      }
      if (player == ghost){
        ghost = -1;
      }

      switch (direction) {
        case "right":
          moveRight();
          break;

        case "up":
          moveUp();

          break;

        case "left":
          moveLeft();

          break;

        case "down":
          moveDown();

          break;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!barries.contains(player + 1)) {
        player += 1;
      }
    });
  }

  void moveUp() {
    setState(() {
      if (!barries.contains(player - numberInRow)) {
        player -= numberInRow;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (!barries.contains(player - 1)) {
        player -= 1;
      }
    });
  }

  void moveDown() {
    setState(() {
      if (!barries.contains(player + numberInRow)) {
        player += numberInRow;
      }
    });
  }

  int ghostX = 0;
  int ghostY = 0;

  void moveGhost() {
    // Implement logic to move the ghost based on a random direction or pathfinding
    setState(() {
      ghostX += ghost;
      ghostY += ghost;
    });
    // Check for collision with Pacman
    if (ghostX == player && ghostY == player) {
      gameOver();
    }
  }

  void gameOver() {
    // Stop timers, display "Game Over" message, etc.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy > 0) {
                    direction = "down";
                  } else if (details.delta.dy < 0) {
                    direction = "up";
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > 0) {
                    direction = "right";
                  } else if (details.delta.dx < 0) {
                    direction = "left";
                  }
                  print(direction);
                },
                child: Container(
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: numberofSqaures,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: numberInRow),
                        itemBuilder: (BuildContext context, int index) {
                          if (mouthClosed){
                            return Padding(padding: EdgeInsets.all(4),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            );
                          }
                         else if (player == index) {
                            switch (direction) {
                              case "left":
                                return Transform.rotate(
                                  angle: pi,
                                  child: MyPlayer(),
                                );
                                break;

                              case "right":
                                return MyPlayer();
                                break;

                              case "up":
                                return Transform.rotate(
                                  angle: 3*pi / 2,
                                  child: MyPlayer(),
                                );
                                break;

                              case "down":
                                return Transform.rotate(
                                  angle: pi / 2,
                                  child: MyPlayer(),
                                );
                                break;
                              default:
                               return MyPlayer();
                            }
                          } else if (barries.contains(index)) {
                            return MyPixel(
                              innercolor: Colors.blue[700],
                              outercolor: Colors.blue[900],
                              // child:Text(index.toString()),
                            );
                          } else {
                            return MyPath(
                              innercolor: Colors.yellow,
                              outercolor: Colors.black,
                              // child:Text(index.toString()),
                            );
                          }
                        }))),
          ),
          Expanded(
              child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Score" + score.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
                GestureDetector(
                  onTap: startGame,
                  child: Text(
                    "P L A Y",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
