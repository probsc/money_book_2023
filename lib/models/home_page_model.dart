import 'package:flutter/material.dart';

import 'records.dart';

/// HomePage のモデルクラス
@immutable
class HomePageModel {
  final List<Records> records;

  const HomePageModel({
    required this.records,
  });

  HomePageModel copyWith({
    List<Records>? records,
  }) {
    return HomePageModel(
      records: records ?? this.records,
    );
  }
}
