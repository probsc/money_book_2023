import 'package:flutter/material.dart';

import '../enums.dart';

/// EditPage のモデルクラス
@immutable
class EditPageModel {
  final DateTime date;
  final TextEditingController dateCtrl;
  final Categories category;
  final TextEditingController titleCtrl;
  final TextEditingController priceCtrl;

  const EditPageModel({
    required this.date,
    required this.dateCtrl,
    required this.category,
    required this.titleCtrl,
    required this.priceCtrl,
  });

  EditPageModel copyWith({
    DateTime? date,
    TextEditingController? dateCtrl,
    Categories? category,
    TextEditingController? titleCtrl,
    TextEditingController? priceCtrl,
  }) {
    return EditPageModel(
      date: date ?? this.date,
      dateCtrl: dateCtrl ?? this.dateCtrl,
      category: category ?? this.category,
      titleCtrl: titleCtrl ?? this.titleCtrl,
      priceCtrl: priceCtrl ?? this.priceCtrl,
    );
  }
}
