import 'package:flutter/material.dart';

import 'app_drawer.dart';
import 'consts.dart';
import 'edit_page.dart';

/// ホーム画面
class HomePage extends StatefulWidget {
  /// コンストラクタ
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Consts.appTitle)),
      body: Container(),
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
      drawer: const AppDrawer(),
    );
  }
}
