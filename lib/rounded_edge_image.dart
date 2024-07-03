import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class RoundedEdgeImage extends StatelessWidget {
  final Uint8List imageBytes;
  final bool isPortrait;

  const RoundedEdgeImage(
      {super.key, required this.imageBytes, this.isPortrait = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Transform.rotate(
              angle: isPortrait ? pi / 2 : 0,
              child: FittedBox(
                  fit: BoxFit.fitWidth, child: Image.memory(imageBytes)),
            )),
      ),
    );
  }
}
