import 'dart:math';
import 'package:entry_scanner/constants.dart';
import 'package:flutter/material.dart';

class StaticFramePainter extends CustomPainter {
  bool isBarcode;

  StaticFramePainter({this.isBarcode = false});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    List<Path> paths = generatePathsStaticFrame(Consts.center);

    for (Path path in paths) {
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  List<Path> generatePathsStaticFrame(Point center) {
    double offset = min(center.x, center.y) - Consts.distToBorder;
    double offset2 = offset;
    if (isBarcode) {
      offset2 = offset / 2;
    }
    double frameLength = offset / 3;

    List<Path> paths = [];
    var topLeft = Path();
    var topRight = Path();
    var bottomLeft = Path();
    var bottomRight = Path();

    topLeft.moveTo(center.x - offset - Consts.frameWidth,
        center.y - offset2 - Consts.frameWidth);
    topLeft.relativeLineTo(frameLength + 2 * Consts.frameWidth, 0);
    topLeft.relativeLineTo(0, 2 * Consts.frameWidth);
    topLeft.relativeLineTo(-frameLength, 0);
    topLeft.relativeLineTo(0, frameLength);
    topLeft.relativeLineTo(-2 * Consts.frameWidth, 0);
    topLeft.relativeLineTo(0, -frameLength - 2 * Consts.frameWidth);
    topLeft.close();
    paths.add(topLeft);

    bottomRight.moveTo(center.x + offset + Consts.frameWidth,
        center.y + offset2 + Consts.frameWidth);
    bottomRight.relativeLineTo(-frameLength - 2 * Consts.frameWidth, 0);
    bottomRight.relativeLineTo(0, -2 * Consts.frameWidth);
    bottomRight.relativeLineTo(frameLength, 0);
    bottomRight.relativeLineTo(0, -frameLength);
    bottomRight.relativeLineTo(2 * Consts.frameWidth, 0);
    bottomRight.relativeLineTo(0, frameLength + 2 * Consts.frameWidth);
    bottomRight.close();
    paths.add(bottomRight);

    bottomLeft.moveTo(center.x - offset - Consts.frameWidth,
        center.y + offset2 + Consts.frameWidth);
    bottomLeft.relativeLineTo(0, -frameLength - 2 * Consts.frameWidth);
    bottomLeft.relativeLineTo(2 * Consts.frameWidth, 0);
    bottomLeft.relativeLineTo(0, frameLength);
    bottomLeft.relativeLineTo(frameLength, 0);
    bottomLeft.relativeLineTo(0, 2 * Consts.frameWidth);
    bottomLeft.relativeLineTo(-frameLength - 2 * Consts.frameWidth, 0);
    bottomLeft.close();
    paths.add(bottomLeft);

    topRight.moveTo(center.x + offset + Consts.frameWidth,
        center.y - offset2 - Consts.frameWidth);
    topRight.relativeLineTo(0, frameLength + 2 * Consts.frameWidth);
    topRight.relativeLineTo(-2 * Consts.frameWidth, 0);
    topRight.relativeLineTo(0, -frameLength);
    topRight.relativeLineTo(-frameLength, 0);
    topRight.relativeLineTo(0, -2 * Consts.frameWidth);
    topRight.relativeLineTo(frameLength + 2 * Consts.frameWidth, 0);
    topRight.close();
    paths.add(topRight);

    return paths;
  }
}
