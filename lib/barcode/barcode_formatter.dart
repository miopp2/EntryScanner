enum BarcodeType { ean13, ean8, upcA, upcE, none }

class BarcodeFormatter {
  BarcodeType detectType(String? barcode) {
    var value = barcode ?? "";
    switch (value.length) {
      case 13:
        return BarcodeType.ean13;
      case 8:
        return BarcodeType.ean8;
      case 12:
        return BarcodeType.upcA;
      case 6:
        return BarcodeType.upcE;
      default:
        return BarcodeType.none;
    }
  }

  String format(String? barcode) {
    var type = detectType(barcode);
    return formatWithType(type, barcode);
  }

  String formatWithType(BarcodeType type, String? barcode) {
    var value = barcode ?? "";
    switch (type) {
      case BarcodeType.ean13:
        var segment1 = value.substring(0, 1);
        var segment2 = value.substring(1, 7);
        var segment3 = value.substring(7, 13);
        return "$segment1 $segment2 $segment3";
      case BarcodeType.ean8:
        var segment1 = value.substring(0, 4);
        var segment2 = value.substring(4, 8);
        return "$segment1 $segment2";
      case BarcodeType.upcA:
        var segment1 = value.substring(0, 6);
        var segment2 = value.substring(6, 12);
        return "$segment1 $segment2";
      case BarcodeType.upcE:
        return value;
      case BarcodeType.none:
        return "Invalid barcode";
    }
  }
}
