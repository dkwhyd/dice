import 'package:dice/dice.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Single extends StatefulWidget {
  const Single({super.key});

  @override
  State<Single> createState() => _SingleState();
}

class _SingleState extends State<Single> {
  String? currentAnimation;
  @override
  void initState() {
    currentAnimation = 'Start';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Single Dice'),
      ),
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: width * 0.8,
              height: height / 1.7,
              child: FlareActor(
                'assets/dice.flr',
                fit: BoxFit.contain,
                animation: currentAnimation,
                
              ),
            ),
            SizedBox(
              width: width / 2.5,
              height: height / 10,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentAnimation = 'Roll';
                    });
                    Dice.wait3seconds().then((_) {
                      callResult();
                    });
                  },
                  child: Text('Play')),
            )
          ],
        ),
      ),
    );
  }

  void callResult() async {
    Map animation = Dice.getRandomAnimation();
    setState(() {
      currentAnimation = animation.values.first;
    });
  }
}