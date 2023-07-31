import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums.dart';
import '../extensions.dart';
import '../models/edit_page_model.dart';
import '../models/records.dart';


/// プロバイダー
final editPageViewModelProvider = StateNotifierProvider.autoDispose
    .family<EditPageViewModel, EditPageModel, Records?>(
        (ref, record) => EditPageViewModel(record));

/// EditPage のビューモデル
class EditPageViewModel extends StateNotifier<EditPageModel> {
  EditPageViewModel(Records? record)
      : super(EditPageModel(
          date: record == null ? DateTime.now() : record!.date,
          dateCtrl: record == null
              ? TextEditingController(text: DateTime.now().toYmd)
              : TextEditingController(text: record!.date.toYmd),
          category: record == null ? Categories.others : record!.category,
          titleCtrl: record == null
              ? TextEditingController()
              : TextEditingController(text: record!.title),
          priceCtrl: record == null
              ? TextEditingController()
              : TextEditingController(text: record!.price.toString()),
        ));

  /// 日付 を更新
  void updateDate(DateTime date) {
    state = state.copyWith(date: date);
  }

  /// 日付 のコントローラのテキストを更新
  void updateDateCtrl(String text) {
    state = state.copyWith(dateCtrl: TextEditingController(text: text));
  }

  /// 分類 を更新
  void updateCategory(Categories category) {
    state = state.copyWith(category: category);
  }
}
