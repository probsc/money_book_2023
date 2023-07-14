import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

import 'db_helper.dart';
import 'enums.dart';
import 'extensions.dart';
import 'records.dart';

/// 編集ページ
class EditPage extends StatefulWidget {
  /// 編集対象のレコード
  final Records? record;

  /// コンストラクタ
  EditPage([this.record]) : super(key: UniqueKey());

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  /// 「日付」コントローラ
  var _txtDate = TextEditingController();

  /// 「日付」の現在地
  var _date = DateTime.now();

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

  /// 「分類」の現在地
  var _category = Categories.others;

  /// 「タイトル」コントローラ
  var _txtTitle = TextEditingController();

  /// 「タイトル」検証用フォームキー
  final _keyTitle = GlobalKey<FormState>();

  /// 「金額」コントローラ
  var _txtPrice = TextEditingController();

  /// 「金額」検証用フォームキー
  final _keyPrice = GlobalKey<FormState>();

  /// 「タイトル」フォーカスノード
  final FocusNode _focusTitle = FocusNode();

  /// 「金額」フォーカスノード
  final FocusNode _focusPrice = FocusNode();

  /// 編集モード？ (true: 編集モード / false: 登録モード)
  bool get isEditMode => widget.record?.id != null;

  @override
  void initState() {
    super.initState();

    _txtDate.text = _date.toYmd;

    // 新規追加ではなく編集？ → 値を画面に反映
    var target = widget.record;
    if (target != null) {
      _date = target.date;
      _txtDate = TextEditingController(text: _date.toYmd);
      _category = target.category;
      _txtTitle = TextEditingController(text: target.title);
      _txtPrice = TextEditingController(text: target.price.toString());
    }
  }

  List<Widget>? _getActions(BuildContext context) {
    // 編集画面でなければ削除ボタンは表示しない
    if (!isEditMode) return null;

    return [
      IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          final ret = await context.confirm('削除しますか？');
          if (ret != true) return;

          DbHelper.deleteRecord(widget.record?.id ?? 0);
          if (mounted) Navigator.pop(context);
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? '編集' : '登録'),
        actions: _getActions(context),
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
                          controller: _txtDate,
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

                  // 呼び元の入力へ通知
                  setState(() {
                    _date = selected;
                    _txtDate.text = _date.toYmd;
                  });
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
                    value: _category,
                    // DropdownButton2 によるプロパティ
                    buttonStyleData: const ButtonStyleData(height: 65),
                    underline: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    onChanged: (Categories? value) {
                      setState(() {
                        _category = value ?? Categories.others;
                      });
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
                      controller: _txtTitle,
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
                      controller: _txtPrice,
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
          final record = widget.record ?? Records();
          record.date = _date;
          record.category = _category;
          record.title = _txtTitle.text;
          record.price = int.parse(_txtPrice.text);
          record.updatedAt = DateTime.now();
          DbHelper.upsertRecord(record);

          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
