import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:money_book_2023/enums.dart';
import 'package:money_book_2023/models/records.dart';
import 'package:money_book_2023/repositories/db_repository_interface.dart';
import 'package:money_book_2023/repositories/test_db_repository.dart';

void main() {
  // DB 関連クラスをテスト用のクラスでオーバーライド
  final container = ProviderContainer(
      overrides: [dbRepositoryProvider.overrideWithValue(TestDbRepository())]);

  var record = Records.fromMap({
    'id': 4,
    'date': DateTime.now(),
    'category': Categories.goods.index,
    'title': 'ボールペン',
    'price': 200,
    'created_at': DateTime.now(),
    'updated_at': DateTime.now(),
  });

  group('DB 関連クラスのテスト', () {
    test('単体テスト　DB にレコードを登録', () async {
      // DB にレコードを保存
      await container.read(dbRepositoryProvider).upsertRecord(record);

      // DB に保存されているレコードを取得
      final records =
          await container.read(dbRepositoryProvider).selectRecords();

      // record が、レコード一覧に保存されているものと一致するか確認
      expect(record, records.firstWhere((element) => element == record));
    });

    test('単体テスト　DB のレコードを編集', () async {
      record.price = 500;

      // DB にレコードを保存
      await container.read(dbRepositoryProvider).upsertRecord(record);

      // DB に保存されているレコードを取得
      final records =
          await container.read(dbRepositoryProvider).selectRecords();

      // record が、レコード一覧に保存されているものと一致するか確認
      expect(record, records.firstWhere((element) => element == record));
    });

    test('単体テスト　DB からレコードを削除', () async {
      // DB からレコードを削除
      await container.read(dbRepositoryProvider).deleteRecord(record.id!);

      // DB に保存されているレコードを取得
      final records =
          await container.read(dbRepositoryProvider).selectRecords();

      // record が、レコード一覧に保存されているか確認
      expect(records.contains(record), isFalse);
    });
  });
}
