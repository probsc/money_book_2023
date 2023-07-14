import 'package:flutter/material.dart';

/// 分類
enum Categories {
  /// その他
  others('その他', Icons.style_outlined),

  /// 食費
  foods('食費', Icons.fastfood_outlined),

  /// 通信
  communications('通信', Icons.language_outlined),

  /// 移動
  travels('移動', Icons.train_outlined),

  /// イベント
  events('イベント', Icons.festival_outlined),

  /// 趣味
  hobbies('趣味', Icons.golf_course_outlined),

  /// ゲーム
  games('ゲーム', Icons.sports_esports_outlined),

  /// 衣服
  clothes('衣服', Icons.checkroom_outlined),

  /// 書籍
  books('書籍', Icons.auto_stories_outlined),

  /// 雑貨
  goods('雑貨', Icons.shopping_bag_outlined),

  /// プレゼント
  gifts('プレゼント', Icons.card_giftcard_outlined),

  /// サブスク
  subscriptions('サブスク', Icons.subscriptions_outlined);

  /// 名称
  final String title;

  /// アイコン
  final IconData icon;

  /// コンストラクタ
  const Categories(this.title, this.icon);
}
