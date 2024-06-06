import 'package:quick_bill/src/common/constants/string_constants.dart';

class Category {
  final String guid;
  final String name;

  Category({required this.guid, required this.name});

  Map<String, dynamic> toMap() {
    return {
      StringConstants.guid: guid,
      StringConstants.name: name,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      guid: map[StringConstants.guid] as String,
      name: map[StringConstants.name] as String,
    );
  }
}
