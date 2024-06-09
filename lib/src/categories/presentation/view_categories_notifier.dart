import 'dart:core';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/categories/models/category.dart';

class ViewCategoriesNotifier extends Notifier<List<Category>> {
  @override
  List<Category> build() {
    return <Category>[
      Category(guid: '1', name: "Birthday Cake"),
      Category(guid: '2', name: "Marriage Cake"),
    ];
  }

  void add(Category newCategory) {
    state = [...state, newCategory];
  }

  void edit(Category editCategory) {
    List<Category> categories = [...state];
    int index =
        categories.indexWhere((category) => category.guid == editCategory.guid);
    Category existing =
        categories.firstWhere((category) => category.guid == editCategory.guid);
    categories.remove(existing);
    categories.insert(index, editCategory);
    state = categories;
  }

  bool delete(Category deleteCategory) {
    bool deleted = state.remove(deleteCategory);
    state = [...state];
    return deleted;
  }
}

final categoriesProvider =
    NotifierProvider<ViewCategoriesNotifier, List<Category>>(
        ViewCategoriesNotifier.new);
