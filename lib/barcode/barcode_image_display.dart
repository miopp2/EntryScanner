import 'package:entry_scanner/rounded_edge_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BarcodeImageDisplay extends StatefulWidget {
  final int barcode;

  const BarcodeImageDisplay({super.key, required this.barcode});

  @override
  State<BarcodeImageDisplay> createState() => _BarcodeImageDisplayState();
}

class _BarcodeImageDisplayState extends State<BarcodeImageDisplay> {
  late Future<Uint8List> barcodeImgFuture;

  @override
  void initState() {
    initializeBarcodeImgFuture();
    super.initState();
  }

  void initializeBarcodeImgFuture() {
    // TODO-mirja (03:07:2024): Implement this method
    // barcodeImgFuture = MealImageStorage().getImage(widget.recID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Title here"),
      ),
      body: FutureBuilder(
        future: barcodeImgFuture,
        builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LinearProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else {
            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 20),
                      child: RoundedEdgeImage(
                        imageBytes: snapshot.data!,
                      ),
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
            );
          }
        },
      ),
    );
  }
}
