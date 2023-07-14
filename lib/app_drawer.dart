import 'package:flutter/material.dart';

import 'package:package_info_plus/package_info_plus.dart';

import 'consts.dart';
import 'graph_page.dart';
import 'home_page.dart';

/// ドロワー
class AppDrawer extends StatelessWidget {
  /// コンストラクタ
  const AppDrawer({Key? key}) : super(key: key);

  /// アプリアイコン
  static final _appIcon = Image.asset(
    'images/icon.png',
    fit: BoxFit.contain,
    width: 64,
    height: 64,
  );

  @override
  Widget build(BuildContext context) {
    // タイトルテキストのテーマ ※ダークテーマ対応のために動的に取得
    final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontSize: 20,
        );

    return SizedBox(
      width: 280,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // アプリタイトル
            SizedBox(
              height: 130,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Row(
                  children: [
                    _appIcon,
                    Text(
                      Consts.appTitle,
                      style: titleStyle,
                    ),
                  ],
                ),
              ),
            ),
            // 「一覧」メニュー
            _getPageMenu(
              Icons.format_list_bulleted,
              '一覧',
              context,
              () => const HomePage(),
            ),
            // 「グラフ」メニュー
            _getPageMenu(
              Icons.pie_chart_outline_outlined,
              'グラフ',
              context,
              () => const GraphPage(),
            ),
            const Divider(color: Colors.black),
            // 「アプリ情報」
            _getMenu(
              Icons.info_outlined,
              'アプリ情報',
              () async => _showInfo(context),
            ),
          ],
        ),
      ),
    );
  }

  /// ドロワーメニューを返す
  Widget _getMenu(
    IconData icon,
    String label,
    VoidCallback onTapped,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: onTapped,
    );
  }

  /// ページ遷移ドロワーメニューを返す
  Widget _getPageMenu(
    IconData icon,
    String label,
    BuildContext context,
    ValueGetter<Widget> page,
  ) {
    return _getMenu(
      icon,
      label,
      () async => await Navigator.pushReplacement(
        context,
        PageRouteBuilder(pageBuilder: (_, __, ___) => page()),
      ),
    );
  }

  Future _showInfo(BuildContext context) async {
    var info = await PackageInfo.fromPlatform();

    // ignore: use_build_context_synchronously
    showAboutDialog(
      context: context,
      applicationIcon: _appIcon,
      applicationName: Consts.appTitle,
      applicationVersion: info.version,
      applicationLegalese: '© 2023 nanairo inc.',
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text(
            'このアプリはインターシップでの題材用の「${Consts.appTitle}アプリ」です。',
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
