// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_page_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EditPageModel {
  DateTime get date => throw _privateConstructorUsedError;
  TextEditingController get dateCtrl => throw _privateConstructorUsedError;
  Categories get category => throw _privateConstructorUsedError;
  TextEditingController get titleCtrl => throw _privateConstructorUsedError;
  TextEditingController get priceCtrl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EditPageModelCopyWith<EditPageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditPageModelCopyWith<$Res> {
  factory $EditPageModelCopyWith(
          EditPageModel value, $Res Function(EditPageModel) then) =
      _$EditPageModelCopyWithImpl<$Res, EditPageModel>;
  @useResult
  $Res call(
      {DateTime date,
      TextEditingController dateCtrl,
      Categories category,
      TextEditingController titleCtrl,
      TextEditingController priceCtrl});
}

/// @nodoc
class _$EditPageModelCopyWithImpl<$Res, $Val extends EditPageModel>
    implements $EditPageModelCopyWith<$Res> {
  _$EditPageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? dateCtrl = null,
    Object? category = null,
    Object? titleCtrl = null,
    Object? priceCtrl = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dateCtrl: null == dateCtrl
          ? _value.dateCtrl
          : dateCtrl // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Categories,
      titleCtrl: null == titleCtrl
          ? _value.titleCtrl
          : titleCtrl // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      priceCtrl: null == priceCtrl
          ? _value.priceCtrl
          : priceCtrl // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EditPageModelCopyWith<$Res>
    implements $EditPageModelCopyWith<$Res> {
  factory _$$_EditPageModelCopyWith(
          _$_EditPageModel value, $Res Function(_$_EditPageModel) then) =
      __$$_EditPageModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime date,
      TextEditingController dateCtrl,
      Categories category,
      TextEditingController titleCtrl,
      TextEditingController priceCtrl});
}

/// @nodoc
class __$$_EditPageModelCopyWithImpl<$Res>
    extends _$EditPageModelCopyWithImpl<$Res, _$_EditPageModel>
    implements _$$_EditPageModelCopyWith<$Res> {
  __$$_EditPageModelCopyWithImpl(
      _$_EditPageModel _value, $Res Function(_$_EditPageModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? dateCtrl = null,
    Object? category = null,
    Object? titleCtrl = null,
    Object? priceCtrl = null,
  }) {
    return _then(_$_EditPageModel(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dateCtrl: null == dateCtrl
          ? _value.dateCtrl
          : dateCtrl // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Categories,
      titleCtrl: null == titleCtrl
          ? _value.titleCtrl
          : titleCtrl // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      priceCtrl: null == priceCtrl
          ? _value.priceCtrl
          : priceCtrl // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
    ));
  }
}

/// @nodoc

class _$_EditPageModel implements _EditPageModel {
  const _$_EditPageModel(
      {required this.date,
      required this.dateCtrl,
      required this.category,
      required this.titleCtrl,
      required this.priceCtrl});

  @override
  final DateTime date;
  @override
  final TextEditingController dateCtrl;
  @override
  final Categories category;
  @override
  final TextEditingController titleCtrl;
  @override
  final TextEditingController priceCtrl;

  @override
  String toString() {
    return 'EditPageModel(date: $date, dateCtrl: $dateCtrl, category: $category, titleCtrl: $titleCtrl, priceCtrl: $priceCtrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EditPageModel &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.dateCtrl, dateCtrl) ||
                other.dateCtrl == dateCtrl) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.titleCtrl, titleCtrl) ||
                other.titleCtrl == titleCtrl) &&
            (identical(other.priceCtrl, priceCtrl) ||
                other.priceCtrl == priceCtrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, date, dateCtrl, category, titleCtrl, priceCtrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EditPageModelCopyWith<_$_EditPageModel> get copyWith =>
      __$$_EditPageModelCopyWithImpl<_$_EditPageModel>(this, _$identity);
}

abstract class _EditPageModel implements EditPageModel {
  const factory _EditPageModel(
      {required final DateTime date,
      required final TextEditingController dateCtrl,
      required final Categories category,
      required final TextEditingController titleCtrl,
      required final TextEditingController priceCtrl}) = _$_EditPageModel;

  @override
  DateTime get date;
  @override
  TextEditingController get dateCtrl;
  @override
  Categories get category;
  @override
  TextEditingController get titleCtrl;
  @override
  TextEditingController get priceCtrl;
  @override
  @JsonKey(ignore: true)
  _$$_EditPageModelCopyWith<_$_EditPageModel> get copyWith =>
      throw _privateConstructorUsedError;
}
