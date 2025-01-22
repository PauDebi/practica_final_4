import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica_final_4/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbProvider {

  static Database? _database;
  static final DbProvider dbProvider = DbProvider._();

  DbProvider._();


  Future<Database> get database async{
    _database ??= await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    // Obtenir el path
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'Scans.db');
    print(path);

    //Crear DB
    return await openDatabase(
        path,
        version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipus TEXT,
            valor TEXT,
            title TEXT
          )
        ''');
        }
    );
  }

  Future<int> insertRawScan(ScanModel nouScan) async {
    final id = nouScan.id;
    final tipus = nouScan.tipus;
    final valor = nouScan.valor;

    final db = await database;
    final res = await db.rawInsert('''
      INSERT INTO Scans(id, tipus, valor)
      VALUES($id, '$tipus', '$valor')
    ''');
    return res;
  }

  Future<int> insertScan(ScanModel nouScan) async {
    final db = await database;
    final res = await db.insert('Scans', nouScan.toMap());
    print(res);
    return res;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');
    List<ScanModel> list = res.isNotEmpty ? res.map((c) => ScanModel.fromMap(c)).toList() : [];
    return list;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    if(res.isNotEmpty) {
      return ScanModel.fromMap(res.first);
    }
    return null;
  }

  Future<List<ScanModel>> getTipusScan(String tipus) async {
    final db = await database;
    final res = await db.query('Scans', where: 'tipus = ?', whereArgs: [tipus]);
    List<ScanModel> list = res.isNotEmpty ? res.map((c) => ScanModel.fromMap(c)).toList() : [];
    return list;
  }

  Future<int> updateScan(ScanModel nouScan) async {
    final db = await database;
    final res = await db.update('Scans', nouScan.toMap(), where: 'id = ?', whereArgs: [nouScan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.delete('Scans');
    return res;
  }

  Future<int> addTitle(ScanModel scan) async {
    final db = await database;
    final res = await db.update('Scans', scan.toMap(), where: 'id = ?', whereArgs: [scan.id]);
    return res;
  }
}