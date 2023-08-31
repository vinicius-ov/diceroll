import 'dart:math';

class Dice {
  int number;

  Dice({required this.number});

  String get name => 'D$number';

  int get rollValue {
    return Random().nextInt(number) + 1;
  }

  String get image {
    switch (number) {
      case 4:
        return 'https://upload.wikimedia.org/wikipedia/commons/1/19/4-sided_dice_250.jpg';
      case 6:
        return 'https://www.dragonheartdice.com/cdn/shop/products/bluered_d6_dbbf82d0-2146-4a0c-8e6d-e5f3115397e7_800x800.jpg';
      case 8:
        return 'http://www.norsefoundry.com/cdn/shop/products/AtomicMetalD8_5000x.jpg';
      case 10:
        return 'https://upload.wikimedia.org/wikipedia/commons/1/19/4-sided_dice_250.jpg';
      case 20:
        return 'https://upload.wikimedia.org/wikipedia/commons/1/19/4-sided_dice_250.jpg';
      default:
        return '';
    }
  }
}
