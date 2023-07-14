import 'enums.dart';
import 'extensions.dart';

/// レコードクラス
class Records {
  /// ID
  int? id;

  /// 日付
  DateTime date;

  /// 分類
  Categories category;

  /// タイトル
  String? title;

  /// 金額
  int? price;

  /// 作成日時
  DateTime createdAt;

  /// 更新日時
  DateTime updatedAt;

  /// コンストラクタ
  Records()
      : date = DateTime.now(),
        category = Categories.others,
        createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  @override
  String toString() => '${date.toYmd} ${price.toYen}';

  /// Records のマップを返す
  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'date': date.toDateText,
        'category': category.index,
        'title': title,
        'price': price,
        'created_at': createdAt.toText,
        'updated_at': updatedAt.toText,
      };

  /// # Map<String, dynamic> を Records に変換
  Records.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        date = map.getDateTime('date'),
        category = Categories.values[map['category']],
        title = map['title'],
        price = map['price'],
        createdAt = map.getDateTime('created_at'),
        updatedAt = map.getDateTime('updated_at');
}
