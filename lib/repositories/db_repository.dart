import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/records.dart';
import 'db_repository_interface.dart';

/// DB 関連クラス
class DbRepository implements DbRepositoryInterface {
  /// DB アクセスオブジェクト
  Database? __db;

  /// DB アクセスオブジェクトを初期化して返す
  Future<Database> get _db async {
    if (__db == null) {
      final dir = await getApplicationDocumentsDirectory();
      final path = join(dir.path, 'money_book_2023.db');
      __db = await openDatabase(path, version: 1, onCreate: _onCreate);
    }
    return __db!;
  }

  /// 「レコード」テーブルの物理名
  final _tableRecords = 'records';

  /// DB 初期化
  Future _onCreate(Database db, int version) async {
    await db.execute('''
create table if not exists '$_tableRecords' (
  'id' integer not null,
  'date' text not null,
  'category' integer not null,
  'title' text not null,
  'price' integer not null,
  'created_at' text not null,
  'updated_at' text not null,
  primary key('id' autoincrement)
);
''');
  }

  @override
  Future<List<Records>> selectRecords() async {
    return (await (await _db).rawQuery('''
select
  *
from
  $_tableRecords
order by
  date desc
  , title
  , created_at desc;
''')).map((n) => Records.fromMap(n)).toList();
  }

  @override
  Future<void> upsertRecord(Records record) async {
    await (await _db).insert(
      _tableRecords,
      record.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteRecord(int id) async {
    await (await _db).delete(
      _tableRecords,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
