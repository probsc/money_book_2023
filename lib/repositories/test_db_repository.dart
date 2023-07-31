import 'dart:math';

import '../enums.dart';
import '../models/records.dart';
import 'db_repository_interface.dart';

/// テスト用のリポジトリ
class TestDbRepository implements DbRepositoryInterface {
  var _records = <Records>[
    Records.fromMap({
      'id': 0,
      'date': DateTime.now(),
      'category': Categories.foods.index,
      'title': 'ラーメン',
      'price': 1000,
      'created_at': DateTime.now(),
      'updated_at': DateTime.now(),
    }),
    Records.fromMap({
      'id': 1,
      'date': DateTime.now(),
      'category': Categories.clothes.index,
      'title': 'シャツ',
      'price': 2000,
      'created_at': DateTime.now(),
      'updated_at': DateTime.now(),
    }),
    Records.fromMap({
      'id': 2,
      'date': DateTime.now(),
      'category': Categories.books.index,
      'title': '辞書',
      'price': 3000,
      'created_at': DateTime.now(),
      'updated_at': DateTime.now(),
    }),
  ];

  @override
  Future<List<Records>> selectRecords() async {
    return _records;
  }

  @override
  Future<void> upsertRecord(Records record) async {
    var index = _records.indexWhere((element) => element.id == record.id);
    if (index != -1) {
      // 既存のレコードの編集
      _records[index] = record;
    } else {
      // レコードの新規登録
      record.id = _getIncrementedId();
      _records.add(record);
    }
    _updateRecords();
  }

  @override
  Future<void> deleteRecord(int id) async {
    _records.removeWhere((element) => element.id == id);
    _updateRecords();
  }

  /// id の最大値 +1 を返す
  int _getIncrementedId() {
    var maxId = _records
        .where((element) => element.id != null)
        .map((e) => e.id!)
        .toList()
        .reduce(max);
    return maxId + 1;
  }

  /// オブジェクトの更新を通知するため、配列を作成しなおす
  void _updateRecords() {
    final updatedRecords = [..._records];
    _records = updatedRecords;
  }
}
