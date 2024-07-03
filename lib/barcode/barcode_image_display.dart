

import 'package:flutter/material.dart';

class BarcodeImageDisplay extends StatelessWidget {
  final int barcode;

  const BarcodeImageDisplay({super.key, required this.barcode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Title here"),
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                  child: Image.asset('assets/$barcode.png'),
                ),
                Text(
                  "Some Text?",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Positioned(
                bottom: 10,
                right: 10,
                child: FloatingActionButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Icon(Icons.analytics_outlined),
                )),
          ],
        ));
  }
}
