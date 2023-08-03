import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums.dart';

part 'edit_page_model.freezed.dart';

/// EditPage のモデルクラス
@freezed
class EditPageModel with _$EditPageModel {
  const factory EditPageModel({
    required DateTime date,
    required TextEditingController dateCtrl,
    required Categories category,
    required TextEditingController titleCtrl,
    required TextEditingController priceCtrl,
  }) = _EditPageModel;
}
