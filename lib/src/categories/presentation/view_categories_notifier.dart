import 'dart:async';
import 'dart:core';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/categories/models/category.dart';
import 'package:quick_bill/src/categories/repository/categories_repository.dart';

class ViewCategoriesNotifier extends AsyncNotifier<List<Category>> {
  late final CategoriesRepository _repository;
  @override
  FutureOr<List<Category>> build() async {
    _repository = ref.watch(categoriesRepositoryProvider);
    return await _repository.getAllCategories();
  }

  void add(Category newCategory) {
    state = AsyncData([...(state.value ?? []), newCategory]);
    _repository.save(entityJSON: newCategory.toMap());
  }

  void edit(Category editCategory) {
    List<Category> categories = [...(state.value ?? [])];
    int index =
        categories.indexWhere((category) => category.guid == editCategory.guid);
    Category existing =
        categories.firstWhere((category) => category.guid == editCategory.guid);
    categories.remove(existing);
    categories.insert(index, editCategory);
    state = AsyncData(categories);
    _repository.editByGUID(
        guid: editCategory.guid, updatedMap: editCategory.toMap());
  }

  bool delete(Category deleteCategory) {
    bool deleted = (state.value ?? []).remove(deleteCategory);
    state = AsyncData([...(state.value ?? <Category>[])]);

    return deleted;
  }
}

final categoriesProvider =
    AsyncNotifierProvider<ViewCategoriesNotifier, List<Category>>(
        ViewCategoriesNotifier.new);
