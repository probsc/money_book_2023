import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:money_book_2023/enums.dart';
import 'package:money_book_2023/repositories/db_repository_interface.dart';
import 'package:money_book_2023/repositories/test_db_repository.dart';
import 'package:money_book_2023/views/home_page.dart';

void main() {
  group('DB 関連クラスのテスト', () {
    testWidgets('ウィジェットテスト　テスト用 DB のレコードが画面に表示できるか確認',
        (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
        overrides: [dbRepositoryProvider.overrideWithValue(TestDbRepository())],
        child: const MaterialApp(home: HomePage()),
      ));

      // 画面の描画が終わるまで待機
      await tester.pumpAndSettle();

      // テスト用に登録したレコードが表示されているか確認
      expect(find.text('ラーメン'), findsOneWidget);
      expect(find.text('シャツ'), findsOneWidget);
      expect(find.text('辞書'), findsOneWidget);

      // 関係ないレコードが表示されていないことを確認
      expect(find.text('仙台っこらーめん'), findsNothing);
      expect(find.text('地下鉄往復'), findsNothing);
      expect(find.text('教養としてのビール'), findsNothing);
    });

    testWidgets('ウィジェットテスト　テスト用 DB にレコードを追加できるか確認',
        (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
        overrides: [dbRepositoryProvider.overrideWithValue(TestDbRepository())],
        child: const MaterialApp(home: HomePage()),
      ));

      // 画面の描画が終わるまで待機
      await tester.pumpAndSettle();

      // レコード追加のために ＋ ボタンをタップし、編集画面へ
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // カレンダーを展開
      await tester.tap(find.byIcon(Icons.date_range));
      await tester.pumpAndSettle();

      // 日付を選択
      await tester.tap(find.text('19'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      // 分類のドロップダウンリストを展開
      await tester.tap(find.byType(DropdownButton2<Categories>));
      await tester.pumpAndSettle();

      // 移動をタップ
      await tester.tap(find.byIcon(Icons.train_outlined));
      await tester.pumpAndSettle();

      // 入力フォームに値を入力
      await tester.enterText(find.byType(TextFormField).at(1), '電車代');
      await tester.enterText(find.byType(TextFormField).at(2), '440');
      await tester.pumpAndSettle();

      // 保存ボタンを押して HomePage に戻る
      await tester.tap(find.byIcon(Icons.save));
      await tester.pumpAndSettle();

      // レコード一覧に追加した内容が表示されているか確認
      expect(find.text('電車代'), findsOneWidget);
    });

    testWidgets('ウィジェットテスト　テスト用 DB のレコードを編集できるか確認',
        (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
        overrides: [dbRepositoryProvider.overrideWithValue(TestDbRepository())],
        child: const MaterialApp(home: HomePage()),
      ));

      // 画面の描画が終わるまで待機
      await tester.pumpAndSettle();

      // 「シャツ」レコードをタップし、編集画面へ
      await tester.tap(find.text('シャツ'));
      await tester.pumpAndSettle();

      // タイトルのフォームの入力値を変更
      await tester.enterText(find.byType(TextFormField).at(1), 'Yシャツ');

      // 保存ボタンを押して HomePage に戻る
      await tester.tap(find.byIcon(Icons.save));
      await tester.pumpAndSettle();

      // レコード一覧に追加した内容が表示されているか確認
      expect(find.text('Yシャツ'), findsOneWidget);
    });

    testWidgets('ウィジェットテスト　テスト用 DB からレコードを削除できるか確認',
        (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
        overrides: [dbRepositoryProvider.overrideWithValue(TestDbRepository())],
        child: const MaterialApp(home: HomePage()),
      ));

      // 画面の描画が終わるまで待機
      await tester.pumpAndSettle();

      // 「シャツ」レコードをタップし、編集画面へ
      await tester.tap(find.text('シャツ'));
      await tester.pumpAndSettle();

      // 削除アイコンをタップ
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      // 「OK」を押し、HomePage に戻る
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      // レコード一覧から削除した内容が消えているか確認
      expect(find.text('Yシャツ'), findsNothing);
    });
  });
}
