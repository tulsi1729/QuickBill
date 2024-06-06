import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/categories/models/category.dart';
import 'package:quick_bill/src/common/backend/database_client.dart';
import 'package:quick_bill/src/common/constants/string_constants.dart';

/// Provider to get categories repository
final categoriesRepositoryProvider = Provider((ref) {
  return CategoriesRepository();
});

class CategoriesRepository {
  final DatabaseClient<Category> _db;
  CategoriesRepository()
      : _db = DatabaseClient(
          StringConstants.categoriesCollectionName,
          Category.fromMap,
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

  Future<List<Category>> getAllCategories() async {
    return _db.getAllEntities();
  }
}
