import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/home_page_model.dart';
import '../models/records.dart';
import '../repositories/db_repository_interface.dart';

/// プロバイダー
final homePageViewModelProvider =
    StateNotifierProvider<HomePageViewModel, HomePageModel>(
        (ref) => HomePageViewModel(repository: ref.read(dbRepositoryProvider)));

/// Future 型を管理するプロバイダー
final homePageViewModelFutureProvider = FutureProvider<HomePageModel>(
  (ref) async {
    await ref.watch(homePageViewModelProvider.notifier).selectRecords();
    return ref.watch(homePageViewModelProvider);
  },
);

/// HomePage のビューモデル
class HomePageViewModel extends StateNotifier<HomePageModel> {
  /// インターフェース
  final DbRepositoryInterface repository;

  /// コンストラクタ
  HomePageViewModel({required this.repository})
      : super(const HomePageModel(records: []));

  /// DB からレコードを取得
  Future<void> selectRecords() async {
    state = state.copyWith(records: await repository.selectRecords());
  }

  /// DB にレコードを追加/更新
  Future<void> upsertRecord(Records record) async {
    await repository.upsertRecord(record);
    await selectRecords();
  }

  /// DB からレコードを削除
  Future<void> deleteRecord(int id) async {
    await repository.deleteRecord(id);
    await selectRecords();
  }
}
