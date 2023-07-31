import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums.dart';
import '../extensions.dart';
import '../models/records.dart';
import '../view_models/edit_page_view_model.dart';
import '../view_models/home_page_view_model.dart';

/// 編集ページ
class EditPage extends ConsumerWidget {
  /// 編集対象のレコード
  final Records? record;

  /// コンストラクタ
  EditPage([this.record]) : super(key: UniqueKey());

  /// 「分類」一覧
  final _categories = Categories.values
      .map(
        (item) => DropdownMenuItem(
          value: item,
          child: Row(
            children: [
              const SizedBox(width: 12),
              Icon(item.icon, color: Colors.grey),
              const SizedBox(width: 12),
              Text(item.title),
            ],
          ),
        ),
      )
      .toList();

  /// 「タイトル」検証用フォームキー
  final _keyTitle = GlobalKey<FormState>();

  /// 「金額」検証用フォームキー
  final _keyPrice = GlobalKey<FormState>();

  /// 「タイトル」フォーカスノード
  final FocusNode _focusTitle = FocusNode();

  /// 「金額」フォーカスノード
  final FocusNode _focusPrice = FocusNode();

  /// 編集モード？ (true: 編集モード / false: 登録モード)
  bool get isEditMode => record?.id != null;

  List<Widget>? _getActions(BuildContext context, WidgetRef ref) {
    // 編集画面でなければ削除ボタンは表示しない
    if (!isEditMode) return null;

    return [
      IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          final ret = await context.confirm('削除しますか？');
          if (ret != true) return;

          // DB からレコードを削除
          ref
              .read(homePageViewModelProvider.notifier)
              .deleteRecord(record?.id ?? 0);

          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(editPageViewModelProvider(record));

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? '編集' : '登録'),
        actions: _getActions(context, ref),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 日付
              GestureDetector(
                child: AbsorbPointer(
                  child: Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('日付'),
                        TextFormField(
                          controller: viewModel.dateCtrl,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.date_range),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () async {
                  var selected = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 3),
                    lastDate: DateTime(DateTime.now().year + 3),
                  );
                  if (selected == null) return;

                  // 日付を更新
                  ref
                      .read(editPageViewModelProvider(record).notifier)
                      .updateDate(selected);

                  // 日付の表示部を更新
                  ref
                      .read(editPageViewModelProvider(record).notifier)
                      .updateDateCtrl(selected.toYmd);
                },
              ),
              const SizedBox(height: 16),
              // 分類
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('分類'),
                  DropdownButton2(
                    isExpanded: true,
                    items: _categories,
                    value: viewModel.category,
                    // DropdownButton2 によるプロパティ
                    buttonStyleData: const ButtonStyleData(height: 65),
                    underline: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    onChanged: (Categories? value) {
                      // 分類を更新
                      ref
                          .read(editPageViewModelProvider(record).notifier)
                          .updateCategory(value ?? Categories.others);
                    },
                  )
                ],
              ),
              const SizedBox(height: 16),

              // タイトル
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('タイトル'),
                  Form(
                    key: _keyTitle,
                    child: TextFormField(
                      controller: viewModel.titleCtrl,
                      //_txtTitle,
                      decoration: const InputDecoration(
                        hintText: '例）電車代',
                        prefixIcon: Icon(Icons.edit_outlined),
                      ),
                      focusNode: _focusTitle,
                      validator: (value) => value == null || value.isEmpty
                          ? 'タイトルを入力してください'
                          : null,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (term) {
                        _focusTitle.changeFocus(context, _focusPrice);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 金額
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('金額'),
                  Form(
                    key: _keyPrice,
                    child: TextFormField(
                      controller: viewModel.priceCtrl,
                      decoration: const InputDecoration(
                        hintText: '例）1000',
                        prefixIcon: Icon(Icons.paid_outlined),
                      ),
                      focusNode: _focusPrice,
                      validator: (value) =>
                          value == null || value.isEmpty ? '金額を入力してください' : null,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: false,
                        signed: false,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 入力チェック
          var isValid = _keyTitle.currentState?.validate() ?? false;
          isValid &= _keyPrice.currentState?.validate() ?? false;
          if (!isValid) return;

          // upsert
          final upDatedRecord = record ?? Records();
          upDatedRecord.date = viewModel.date;
          upDatedRecord.category = viewModel.category;
          upDatedRecord.title = viewModel.titleCtrl.text;
          upDatedRecord.price = int.parse(viewModel.priceCtrl.text);
          upDatedRecord.updatedAt = DateTime.now();

          // DB にレコードを追加/更新
          ref
              .read(homePageViewModelProvider.notifier)
              .upsertRecord(upDatedRecord);

          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
