import 'package:flutter/material.dart';

import 'app_drawer.dart';
import 'consts.dart';

/// グラフ画面
class GraphPage extends StatefulWidget {
  /// コンストラクタ
  const GraphPage({Key? key}) : super(key: key);

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Consts.appTitle)),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text('Graph page.'),
      ),
    );
  }
}
