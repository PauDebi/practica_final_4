import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerWidget extends StatefulWidget {
  const QRScannerWidget({Key? key}) : super(key: key);

  @override
  _QRScannerWidgetState createState() => _QRScannerWidgetState();
}

class _QRScannerWidgetState extends State<QRScannerWidget> {
  bool _isScanning = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner'),
      ),
      body: _isScanning
          ? MobileScanner(
        onDetect: (barcodeCapture) {
          // Solo se recibe un argumento: BarcodeCapture
          final barcode = barcodeCapture.barcodes.first;
          if (barcode.rawValue != null && _isScanning) {
            setState(() {
              _isScanning = false;
            });
            final String qrValue = barcode.rawValue!;
            Navigator.pop(context, qrValue); // Retorna el valor del QR
          }
        },
      )
          : const Center(
        child: Text('Scanning stopped.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isScanning = true;
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
