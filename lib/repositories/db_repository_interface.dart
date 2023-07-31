import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/records.dart';
import 'db_repository.dart';

/// DB 関連クラスのインターフェース
abstract class DbRepositoryInterface {
  Future<List<Records>> selectRecords();

  Future<void> upsertRecord(Records record);

  Future<void> deleteRecord(int id);
}

final dbRepositoryProvider =
    Provider<DbRepositoryInterface>((ref) => DbRepository());
