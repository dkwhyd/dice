import 'package:dice/dice.dart';
import 'package:dice/screen/single.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class KnockOutScreen extends StatefulWidget {
  const KnockOutScreen({super.key});

  @override
  State<KnockOutScreen> createState() => _KnockOutScreenState();
}

class _KnockOutScreenState extends State<KnockOutScreen> {
  int? _playerScore = 0;
  int? _aiScore = 0;
  String? _animation1;
  String? _animation2;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _animation1 = 'Start';
    _animation2 = 'Start';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Knockout Game'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Single()));
              },
              icon: const Icon(Icons.repeat_one))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: height / 3,
                    width: width / 2.5,
                    child: FlareActor(
                      'assets/dice.flr',
                      fit: BoxFit.contain,
                      animation: _animation1,
                    ),
                  ),
                  SizedBox(
                    height: height / 3,
                    width: width / 2.5,
                    child: FlareActor(
                      'assets/dice.flr',
                      fit: BoxFit.contain,
                      animation: _animation2,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const GameText(
                    text: 'Player',
                    color: Colors.deepOrange,
                    isBordered: false,
                  ),
                  GameText(
                    text: _playerScore.toString(),
                    color: Colors.white,
                    isBordered: true,
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(height / 24)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const GameText(
                    text: 'AI',
                    color: Colors.lightBlue,
                    isBordered: false,
                  ),
                  GameText(
                    text: _aiScore.toString(),
                    color: Colors.white,
                    isBordered: true,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(height / 12),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: width / 3,
                    height: height / 10,
                    child: ElevatedButton(
                      onPressed: () {
                        play(context);
                      },
                      child: const Text('Play'),
                    ),
                  ),
                  SizedBox(
                    width: width / 3,
                    height: height / 10,
                    child: ElevatedButton(
                      onPressed: () {
                        reset(context);
                      },
                      child: const Text('Restart'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void reset(BuildContext context) {
    setState(() {
      _animation1 = 'Start';
      _animation2 = "start";
      _aiScore = 0;
      _playerScore = 0;
    });
  }

  Future showMessage(String message) async {
    SnackBar snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future play(BuildContext context) async {
    String message = '';

    setState(() {
      _animation1 = 'Roll';
      _animation2 = 'Roll';

      Dice.wait3seconds().then((_) {
        Map animation1 = Dice.getRandomAnimation();
        Map animation2 = Dice.getRandomAnimation();
        int result = Dice.getRandomNumber() + Dice.getRandomNumber();
        int aiResult = Dice.getRandomNumber() + Dice.getRandomNumber();

        if (result == 7) {
          result = 0;
        }

        if (aiResult == 7) {
          aiResult = 0;
        }

        setState(() {
          _playerScore = _playerScore! + result;
          _aiScore = _aiScore! + aiResult;
          _animation1 = animation1.values.first;
          _animation2 = animation2.values.first;
        });

     
        if (_playerScore! >= 50 || _aiScore! >= 50) {
          if (_playerScore! > _aiScore!) {
            message = 'You Win';
            showMessage(message);
          } else if (_playerScore! == _aiScore!) {
            message = 'Draw';
            showMessage(message);
          } else {
            message = 'You Lose';
            showMessage(message);
          }
        }
      });
    });
  }
}

class GameText extends StatelessWidget {
  final String text;
  final Color color;
  final bool isBordered;
  const GameText(
      {super.key,
      required this.text,
      required this.color,
      required this.isBordered});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: isBordered ? Border.all() : null,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: color),
      ),
    );
  }
}
