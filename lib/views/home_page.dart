import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../consts.dart';
import '../view_models/edit_page_view_model.dart';
import '../view_models/home_page_view_model.dart';
import '../widgets/app_drawer.dart';
import 'edit_page.dart';

/// ホーム画面
class HomePage extends ConsumerWidget {
  /// コンストラクタ - スクロール位置保持のために PageStorageKey を指定
  const HomePage() : super(key: const PageStorageKey<String>('home'));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text(Consts.appTitle)),
      drawer: const AppDrawer(),
      body: ref.watch(homePageViewModelFutureProvider).when(
            data: (data) {
              return ListView.builder(
                itemCount: data.records.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(data.records[index].category.icon),
                    title: Text(data.records[index].title ?? '---'),
                    subtitle: Text(data.records[index].toString()),
                    onTap: () async {
                      // 編集画面に遷移
                      await Navigator.push(context, MaterialPageRoute(
                        builder: (_) {
                          return ProviderScope(
                            overrides: [
                              editPageVMProvider.overrideWith((ref) =>
                                  EditPageViewModel(data.records[index])),
                            ],
                            child: EditPage(data.records[index]),
                          );
                        },
                      ));
                    },
                  );
                },
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) {
              debugPrint('Error: $error,$stackTrace');
              return const Text('エラーが発生しました');
            },
          ),

      // 新規追加ボタン
      floatingActionButton: FloatingActionButton(
        tooltip: '新規追加',
        onPressed: () async {
          // 編集画面に遷移
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => EditPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
