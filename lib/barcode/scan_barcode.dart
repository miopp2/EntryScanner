import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:entry_scanner/barcode/barcode_handler.dart';
import 'package:entry_scanner/barcode/barcode_image_display.dart';
import 'package:entry_scanner/barcode/barcode_text.dart';
import 'package:entry_scanner/constants.dart';
import 'package:entry_scanner/static_frame_painter.dart';
import 'package:flutter/material.dart';

class ScanBarcode extends StatefulWidget {
  const ScanBarcode({super.key});

  @override
  ScanBarcodeState createState() => ScanBarcodeState();
}

class ScanBarcodeState extends State<ScanBarcode> with WidgetsBindingObserver {
  AnalysisController? _analysisController;
  bool setConsts = true;
  List<int> refBarcodes = [
    014503766,
    019262968,
    038228596,
    066310331,
    113130200,
    127065119,
    132871149,
    153162652,
    235699409,
    239246163,
    265747304,
    272641796,
    281168656,
    290112843,
    299542120,
    304173578,
    358269572,
    372569200,
    375483217,
    379898316,
    384523882,
    390102132,
    398963102,
    404434013,
    417840557,
    529928177,
    558705485,
    584884320,
    590502181,
    622170230,
    677439551,
    682289178,
    682609464,
    684680157,
    712342244,
    726265000,
    747188404,
    759069982,
    780977408,
    782336184,
    797464119,
    816304051,
    825452681,
    829979420,
    831745278,
    864945004,
    887914709,
    918277710,
    919683160,
    939362241,
    941343172,
    954448304,
    983937092,
    991234673,
  ];

  final staticFramePainter = StaticFramePainter(isBarcode: true);
  final barcodeHandler = BarcodeHandler();

  @override
  void initState() {
    super.initState();
    _analysisController?.start();
    super.initState();
  }

  @override
  void dispose() {
    _analysisController?.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        Consts.screenSize = constraints.biggest;
        if (setConsts) {
          computeConsts(constraints.biggest);
          setConsts = false;
        }
        return Stack(
          children: [
            CameraAwesomeBuilder.custom(
              builder: (CameraState state, Preview preview) {
                _analysisController = state.analysisController;
                return (state.when(
                  onPhotoMode: (state) {
                    return AwesomeCameraLayout(
                      state: state,
                    );
                  },
                ));
              },
              saveConfig: SaveConfig.photo(pathBuilder: (sensor) async {
                return SingleCaptureRequest("filePath", sensor.first);
              }),
              imageAnalysisConfig: AnalysisConfig(
                maxFramesPerSecond: 15,
              ),
              sensorConfig: SensorConfig.single(
                  flashMode: FlashMode.auto,
                  aspectRatio: CameraAspectRatios.ratio_16_9,
                  sensor: Sensor.position(SensorPosition.back)),
              previewFit: CameraPreviewFit.fitWidth,
              onImageForAnalysis: (img) => _processBarcode(img),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: CustomPaint(
                      painter: staticFramePainter,
                    ),
                  ),
                  const BarcodeText(barcodes: []),
                ])
          ],
        );
      }),
    );
  }

  _processBarcode(AnalysisImage img) async {
    var results = await barcodeHandler.scanBarcode(img);
    if (!mounted) return;
    if (results.isNotEmpty) {
      _analysisController?.stop();
      if (refBarcodes.contains(results[0])) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BarcodeImageDisplay(barcode: results[0]!),
          ),
        );
        _analysisController?.start();
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Warning'),
              content: const Text('Barcode not found in reference list'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _analysisController?.start();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }
}
