import 'package:flutter/material.dart';
import 'package:practica_final_4/utils/utils.dart';
import 'package:provider/provider.dart';

import '../models/scan_model.dart';
import '../providers/scan_list_provider.dart';
import '../screens/qr_reader.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(
        Icons.filter_center_focus,
      ),
      onPressed: () => _scanQR(context),
    );
  }
  void _scanQR(BuildContext context) async {
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
    String? scanModelText = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QRScannerWidget()),
    );

    if (scanModelText != null) {
      ScanModel scanModel = ScanModel(valor: scanModelText);
      scanListProvider.newScan(scanModelText);
      launchURL(context, scanModel);
    }
  }
}
