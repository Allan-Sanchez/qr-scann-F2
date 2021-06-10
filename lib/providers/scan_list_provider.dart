import 'package:flutter/material.dart';
import 'package:qr_scanner/models/scan_model.dart';
import 'package:qr_scanner/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scanList = [];
  String typeSelected = 'http';

  Future<ScanModel> newScanProvider(String value) async {
    final newScan = new ScanModel(value: value);
    final id = await DBProvider.instance.newScan(newScan);

    newScan.id = id;

    if (this.typeSelected == newScan.type) {
      this.scanList.add(newScan);
      notifyListeners();
    }
    return newScan;
  }

  getScansProvider() async {
    final scans = await DBProvider.instance.getAllScan();
    this.scanList = [...scans];
    notifyListeners();
  }

  getScansForTypeProvider(String type) async {
    final scansForType = await DBProvider.instance.getScansForType(type);
    this.scanList = [...scansForType];
    this.typeSelected = type;
    notifyListeners();
  }

  deleteAllProvider() async {
    await DBProvider.instance.deleteAllScan();
    this.scanList = [];
    notifyListeners();
  }

  deleteScanProvider(int id) async {
    await DBProvider.instance.deleteScan(id);
  }
}
