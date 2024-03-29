import 'dart:math';

class Dice {
  static List animations = ['Set1', 'Set2', 'Set3', 'Set4', 'Set5', 'Set6'];

  static getRandomNumber() {
    var random = Random();
    int num = random.nextInt(5) + 1;
    return num;
  }

  static Map<int, String> getRandomAnimation() {
    var random = Random();
    int num = random.nextInt(animations.length);
    int animationKey = num + 1;
    String animationValue = animations[num];
    Map<int, String> result = {animationKey: animationValue};
    return result;
  }

  static Future wait3seconds() {
    return Future.delayed(const Duration(seconds: 2), () {});
  }
}
