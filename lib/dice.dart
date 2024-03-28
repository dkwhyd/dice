import 'dart:math';

class Dice {
  static List animations = ['Set1', 'Set2', 'Set3', 'Set4', 'Set5', 'Set6'];

  static getRandomNumber() {
    var random = Random();
    int num = random.nextInt(5) + 1;
    return num;
  }

  static Map getRandomAnimation() {
    var random = Random();
    int num = random.nextInt(5);
    Map result = {num: animations[num]};
    return result;
  }

  static Future wait3seconds() {
    return Future.delayed(const Duration(seconds: 2), () {});
  }
}
