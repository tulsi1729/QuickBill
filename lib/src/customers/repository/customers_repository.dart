import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/common/backend/database_client.dart';
import 'package:quick_bill/src/common/constants/string_constants.dart';
import 'package:quick_bill/src/customers/models/customer.dart';

/// Provider to get customers repository
final customersRepositoryProvider = Provider((ref) {
  return CustomersRepository();
});

class CustomersRepository {
  final DatabaseClient<Customer> _db;
  CustomersRepository()
      : _db = DatabaseClient(
          StringConstants.customersCollectionName,
          Customer.fromMap,
        );

  Future<void> save({required customerJSON}) async {
    _db.insert(entityJSON: customerJSON);
  }

  Future<void> editByGUID(
      {required String guid,
      required Map<String, dynamic> updatedCustomerMap}) async {
    _db.editByGUID(guid: guid, updatedEntityMap: updatedCustomerMap);
  }

  Future<void> deleteByGUID({required String guid}) async {
    _db.deleteByGUID(guid: guid);
  }

  Future<List<Customer>> getAllCustomers() async {
    return _db.getAllEntities();
  }
}
