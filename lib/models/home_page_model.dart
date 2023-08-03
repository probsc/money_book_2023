import 'package:freezed_annotation/freezed_annotation.dart';

import 'records.dart';

part 'home_page_model.freezed.dart';

/// HomePage のモデルクラス
@freezed
class HomePageModel with _$HomePageModel {
  const factory HomePageModel({
    required List<Records> records,
  }) = _HomePageModel;
}
