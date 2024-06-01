import 'package:quick_bill/src/common/constants/string_constants.dart';

class Customer {
  final String guid;
  final String name;
  const Customer({required this.guid, required this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      StringConstants.guid: guid,
      StringConstants.name: name,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      guid: map[StringConstants.guid],
      name: map[StringConstants.name],
    );
  }
}
