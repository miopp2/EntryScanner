import 'dart:math';
import 'dart:ui';

class Consts {
  static Size screenSize = const Size(0.0, 0.0);
  static const double distToBorder = 10.0;
  static const double frameWidth = 4.0;
  static const double frameLength = frameWidth / 3.0;

  static var offset = 0.0;
  static var heightOffset = 0.0;
  static var center = const Point(0.0, 0.0);


  static Size imageSize = const Size(0.0, 0.0);

  static void setImageSize(Size size) {
    imageSize = size;
  }
}

void computeConsts(Size imageSize) {
  Consts.heightOffset = (imageSize.height - (imageSize.width * (4 / 3))) / 2;
  Consts.center =
      Point(imageSize.width / 2, imageSize.height / 2 - Consts.heightOffset);

  if (imageSize.width > imageSize.height) {
    Consts.center = Point(
        Consts.center.x + (imageSize.width - imageSize.height) / 2,
        Consts.center.y);
  } else {
    Consts.center = Point(Consts.center.x,
        Consts.center.y + (imageSize.height - imageSize.width) / 2);
  }

  Consts.offset = min(Consts.center.x, Consts.center.y) - Consts.distToBorder;
}
