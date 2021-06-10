import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:qr_scanner/models/scan_model.dart';

class DBProvider {
  static final DBProvider instance = DBProvider._init();
  static Database _database;
  DBProvider._init();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('ScanDB.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print(path);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    return await db.execute('''
    CREATE TABLE scans (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      type TEXT NO NULL,
      value TEXT NO NULL
    )
    ''');
  }

  Future<int> newScanRaw(ScanModel newScan) async {
    final id = newScan.id;
    final type = newScan.type;
    final value = newScan.value;

    final db = await instance.database;

    final res = await db.rawInsert('''
    INSERT INTO scans (id, type, value)
      VALUES ($id, '$type', '$value')
    ''');
    return res;
  }

//add one new scan
  Future<int> newScan(ScanModel newScan) async {
    final db = await instance.database;
    final res = await db.insert('scans', newScan.toJson());
    return res;
  }

  //get one scan
  Future<ScanModel> getScanById(int id) async {
    final db = await instance.database;
    final res = await db.query('scans', where: 'id = ?', whereArgs: [id]);
    //devolvemos una instancia de la clase scanmodel
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : [];
  }

  //get all scan
  Future<List<ScanModel>> getAllScan() async {
    final db = await instance.database;
    final res = await db.query('scans');

    return res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];
  }

  // get scans for type
  Future<List<ScanModel>> getScansForType(String type) async {
    final db = await instance.database;
    // final res = await db.query('scans', where: 'type = ?', whereArgs: [type]);
    final res = await db.rawQuery('''
    SELECT * FROM scans WHERE type = '$type'
    ''');

    return res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];
  }

  //update one scan
  Future<int> updateScan(ScanModel newScan) async {
    final db = await instance.database;
    final res = await db.update('scans', newScan.toJson(),
        where: 'id = ?', whereArgs: [newScan.id]);

    return res;
  }

  // delete one scan
  Future<int> deleteScan(int id) async {
    final db = await instance.database;
    final res = await db.delete('scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  //delete all scan of the db
  Future<int> deleteAllScan() async {
    final db = await instance.database;
    final res = await db.delete('scans');
    return res;
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
