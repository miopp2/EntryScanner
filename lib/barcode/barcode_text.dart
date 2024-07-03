
import 'package:entry_scanner/barcode/barcode_formatter.dart';
import 'package:flutter/material.dart';

class BarcodeText extends StatelessWidget {
  final List<int?> barcodes;

  const BarcodeText({super.key, required this.barcodes});

  @override
  Widget build(BuildContext context) {
    final BarcodeFormatter barcodeFormatter = BarcodeFormatter();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 50),
      child: Text(
        barcodes.isNotEmpty
            ? barcodes
                .map((barcode) => barcodeFormatter.format(barcode.toString()))
                .join(',\n ')
            : "No barcode found, yet",
        style: Theme.of(context).textTheme.headlineMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}
