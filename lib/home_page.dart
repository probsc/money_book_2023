import 'package:flutter/material.dart';

import 'app_drawer.dart';
import 'consts.dart';
import 'db_helper.dart';
import 'edit_page.dart';
import 'records.dart';

/// ホーム画面
class HomePage extends StatefulWidget {
  /// コンストラクタ - スクロール位置保持のために PageStorageKey を指定
  const HomePage() : super(key: const PageStorageKey<String>('home'));

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Consts.appTitle)),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: DbHelper.selectRecords(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<Records>> snapshot,
        ) {
          // データが準備できていない場合はプログレスアイコンを表示
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, int index) {
              final record = snapshot.data![index];
              return ListTile(
                leading: Icon(record.category.icon),
                title: Text(record.title ?? '---'),
                subtitle: Text(record.toString()),
                onTap: () async {
                  // 編集画面に遷移
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EditPage(record)),
                  );

                  // 一覧を更新
                  setState(() {});
                },
              );
            },
          );
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

          // 一覧を更新
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
