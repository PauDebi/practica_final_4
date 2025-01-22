import 'package:flutter/cupertino.dart';
import 'package:practica_final_4/providers/db_provider.dart';

import '../models/scan_model.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String selectedType = 'http';

  Future<ScanModel> newScan(String value) async {
    final newScan = ScanModel(valor: value);
    final id = await DbProvider.dbProvider.insertScan(newScan);
    newScan.id = id;
    if (newScan.tipus == selectedType) {
      scans.add(newScan);
    }
    notifyListeners();
    return newScan;
  }

  carrregarScans() async {
    final scans = await DbProvider.dbProvider.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  carrregarScansPerTipus(String tipus) async {
    final scans = await DbProvider.dbProvider.getTipusScan(tipus);
    this.scans = [...scans];
    selectedType = tipus;
    notifyListeners();
  }

  esborrarScans() async {
    await DbProvider.dbProvider.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  esborrarScanPerId(int id) async {
    await DbProvider.dbProvider.deleteScan(id);
    carrregarScans();
  }

  addTitle(ScanModel scan) async {
    await DbProvider.dbProvider.addTitle(scan);
    print(scan.title);
    carrregarScansPerTipus(scan.tipus!);
  }
}