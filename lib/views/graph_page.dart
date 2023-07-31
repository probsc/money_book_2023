import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../consts.dart';
import '../widgets/app_drawer.dart';

/// グラフ画面
class GraphPage extends ConsumerWidget {
  /// コンストラクタ
  const GraphPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text(Consts.appTitle)),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text('Graph page.'),
      ),
    );
  }
}
