import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/common/backend/database_client.dart';
import 'package:quick_bill/src/common/constants/string_constants.dart';
import 'package:quick_bill/src/products/models/product.dart';

/// Provider to get products repository
final productsRepositoryProvider = Provider((ref) {
  return ProductsRepository();
});

class ProductsRepository {
  final DatabaseClient<Product> _db;
  ProductsRepository()
      : _db = DatabaseClient(
          StringConstants.productsCollectionName,
          Product.fromMap,
        );

  Future<void> save({required entityJSON}) async {
    _db.insert(entityJSON: entityJSON);
  }

  Future<void> editByGUID(
      {required String guid, required Map<String, dynamic> updatedMap}) async {
    _db.editByGUID(guid: guid, updatedEntityMap: updatedMap);
  }

  Future<void> deleteByGUID({required String guid}) async {
    _db.deleteByGUID(guid: guid);
  }

  Future<List<Product>> getAllProducts() async {
    return _db.getAllEntities();
  }
}
