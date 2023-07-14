import 'package:flutter/material.dart';

import 'consts.dart';

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
    );
  }
}
