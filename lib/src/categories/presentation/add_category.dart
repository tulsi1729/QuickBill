import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/categories/models/categories.dart';
import 'package:quick_bill/src/categories/presentation/view_categories_notifier.dart';
import 'package:quick_bill/src/localization/app_localizations_context.dart';
import 'package:uuid/uuid.dart';

class AddCategory extends ConsumerWidget {
  final bool isEditMode;
  final Category? preFillCategory;

  AddCategory({
    super.key,
    this.isEditMode = false,
    this.preFillCategory,
  });
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(categoriesProvider);
    final addCategoryController =
        TextEditingController(text: preFillCategory?.name ?? '');
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.addCategoryTitle),
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: addCategoryController,
                decoration: InputDecoration(
                    hintText: context.l10n.categoryLabelRequiredMessage),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (isEditMode) {
                      final editCategory = Category(
                        guid: preFillCategory!.guid,
                        name: addCategoryController.text,
                      );
                      ref.read(categoriesProvider.notifier).edit(editCategory);
                      Navigator.pop(context);
                    } else {
                      final newCategory = Category(
                          guid: const Uuid().v4(),
                          name: addCategoryController.text);
                      ref.read(categoriesProvider.notifier).add(newCategory);
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text(context.l10n.saveCategoryLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
