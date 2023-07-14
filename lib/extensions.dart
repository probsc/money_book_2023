import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

/// int 関連の拡張メソッド
extension IntExtention on int? {
  static final _formatComma = NumberFormat('#,###');

  /// 整数値からカンマ付き円表記の文字列を返す
  String get toYen => '${_formatComma.format(this ?? 0)}円';
}

/// DateTime 関連の拡張メソッド
extension DateTimeExtension on DateTime {
  static final _formatDateTime = DateFormat('yyyy-MM-dd HH:mm:ss');
  static final _formatDate = DateFormat('yyyy-MM-dd');
  static const _week = [
    '月',
    '火',
    '水',
    '木',
    '金',
    '土',
    '日',
  ];

  /// 日付から [yyyy-MM-dd HH:mm:ss] 形式の文字列を返す
  String get toText => _formatDateTime.format(this);

  /// 日付から [yyyy-MM-dd] 形式の文字列を返す
  String get toDateText => _formatDate.format(this);

  /// 日付から [yyyy-MM-dd(aaa)] 形式の文字列を返す
  String get toYmd => '${_formatDate.format(this)} (${_week[weekday - 1]})';
}

/// Map<String, dynamic> 関連の拡張メソッド
extension MapExtension on Map<String, dynamic> {
  /// 指定キーの DateTime 要素を返す
  DateTime getDateTime(String key) {
    var v = this[key];
    return v == null || v is! String ? DateTime.now() : DateTime.parse(v);
  }
}

/// FocusNode 関連の拡張メソッド
extension FocusNodeExtension on FocusNode {
  /// 指定キーの DateTime 要素を返す
  void changeFocus(BuildContext context, FocusNode next) {
    unfocus();
    FocusScope.of(context).requestFocus(next);
  }
}

/// BuildContext 関連の拡張メソッド
extension BuildContextExtension on BuildContext {
  /// confirm dialog の表示
  Future<bool?> confirm(String question) async => await showDialog<bool>(
    context: this,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      content: Text(question),
      actions: [
        SimpleDialogOption(
          child: const Text('キャンセル'),
          onPressed: () => Navigator.pop(context, false),
        ),
        SimpleDialogOption(
          child: const Text('OK'),
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    ),
  );
}
