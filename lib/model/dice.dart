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
        return 'https://cdn11.bigcommerce.com/s-70184/images/stencil/1280x1280/products/3874/10649/d4-dice-numeral-transparent-purple__05445.1652305970.jpg';
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
