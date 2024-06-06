import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/categories/models/category.dart';
import 'package:quick_bill/src/categories/presentation/add_category.dart';
import 'package:quick_bill/src/categories/presentation/view_categories_notifier.dart';
import 'package:quick_bill/src/localization/app_localizations_context.dart';

class ViewCategories extends ConsumerWidget {
  const ViewCategories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Category>> categoriesAsync = ref.watch(categoriesProvider);
    return categoriesAsync.when(
        data: (categories) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                context.l10n.viewCategoriesTitle,
              ),
              elevation: 5,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: categories.isEmpty
                    ? Text(context.l10n.noCategoryMessage)
                    : ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: ((context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                categories[index].name,
                                style: const TextStyle(fontSize: 30),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                      onPressed: () {
                                        final isDeleteDone = ref
                                            .read(categoriesProvider.notifier)
                                            .delete(categories[index]);

                                        String message = "";
                                        if (isDeleteDone) {
                                          message = context.l10n
                                              .categoryRequiredMessageDelete;
                                        } else {
                                          message = context.l10n
                                              .categoryRequiredMessageNotDelete;
                                        }

                                        SnackBar snackBar =
                                            SnackBar(content: Text(message));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      },
                                      icon: const Icon(Icons.delete)),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddCategory(
                                                    preFillCategory:
                                                        categories[index],
                                                    isEditMode: true,
                                                  )),
                                        );
                                      },
                                      icon: const Icon(Icons.edit)),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCategory()),
                );
              },
              child: const Icon(Icons.add),
            ),
          );
        },
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
        error: (error, _) => Text(error.toString()));
  }
}
