import 'package:flutter/material.dart';

/// 編集ページ
class EditPage extends StatefulWidget {
  /// コンストラクタ
  EditPage() : super(key: UniqueKey());

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}
