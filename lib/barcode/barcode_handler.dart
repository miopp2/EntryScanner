import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class BarcodeHandler {
  final BarcodeScanner barcodeScanner = BarcodeScanner(formats: [
    BarcodeFormat.upca,
    BarcodeFormat.upce,
    BarcodeFormat.ean8,
    BarcodeFormat.ean13
  ]);

  Future<List<int?>> scanBarcode(AnalysisImage image) async {
    final InputImage inputImage = image.toInputImage();
    final List<Barcode> barcodes =
        await barcodeScanner.processImage(inputImage);
    final List<int?> strings = barcodes
        .map((barcode) => barcode.displayValue != null
            ? int.parse(barcode.displayValue!)
            : null)
        .toList();
    return strings;
  }

  Future<void> stopAnalysis() async {
    await barcodeScanner.close();
  }
}

extension MLKitUtils on AnalysisImage {
  InputImage toInputImage() {
    return when(
      nv21: (image) {
        return InputImage.fromBytes(
          bytes: image.bytes,
          metadata: InputImageMetadata(
            rotation: inputImageRotation,
            format: InputImageFormat.nv21,
            size: image.size,
            bytesPerRow: image.planes.first.bytesPerRow,
          ),
        );
      },
      bgra8888: (image) {
        return InputImage.fromBytes(
          bytes: image.bytes,
          metadata: InputImageMetadata(
            rotation: inputImageRotation,
            size: image.size,
            format: InputImageFormat.bgra8888,
            bytesPerRow: image.planes.first.bytesPerRow,
          ),
        );
      },
    )!;
  }

  InputImageRotation get inputImageRotation =>
      InputImageRotation.values.byName(rotation.name);
}