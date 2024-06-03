import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/categories/models/category.dart';
import 'package:quick_bill/src/categories/presentation/view_categories_notifier.dart';
import 'package:quick_bill/src/localization/app_localizations_context.dart';
import 'package:quick_bill/src/products/models/product.dart';
import 'package:quick_bill/src/products/presentation/view_products_notifier.dart';
import 'package:uuid/uuid.dart';

class AddProduct extends ConsumerStatefulWidget {
  const AddProduct({super.key, this.isEditMode = false, this.preFillProduct});
  final bool isEditMode;
  final Product? preFillProduct;
  @override
  ConsumerState<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends ConsumerState<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List<Category> categories = ref.watch(categoriesProvider);
    final addProductController =
        TextEditingController(text: widget.preFillProduct?.name ?? '');
    final priceProductController =
        TextEditingController(text: widget.preFillProduct?.price.toString());
    final descriptionProductController =
        TextEditingController(text: widget.preFillProduct?.description ?? '');

    String? selectedCategoryGUID = widget.preFillProduct?.categoryGuid;

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.isEditMode
              ? context.l10n.editProductTitle
              : context.l10n.addProductTitle),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: addProductController,
                decoration: InputDecoration(
                  hintText: context.l10n.productNameLabelRequiredMessage,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n.productNameRequiredMessage;
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descriptionProductController,
                decoration: InputDecoration(
                  hintText: context.l10n.productDescriptionLabelRequiredMessage,
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: priceProductController,
                      decoration: InputDecoration(
                        hintText: context.l10n.productPriceLabelRequiredMessage,
                        suffixIcon: const Icon(Icons.currency_rupee),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.l10n.productPriceRequiredMessage;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: DropdownButtonFormField<String>(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.l10n.productCategorySelectedMessage;
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText:
                            context.l10n.productCategorySelectedLabelMessage,
                      ),
                      onChanged: (value) {
                        // setState(() {
                        selectedCategoryGUID = value!;
                        // });
                      },
                      value: selectedCategoryGUID,
                      icon: const Icon(Icons.menu),
                      items: categories.map((valueItem) {
                        return DropdownMenuItem<String>(
                          value: valueItem.guid,
                          child: Text(valueItem.name),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.isEditMode) {
                        final editProduct = Product(
                            name: addProductController.text,
                            price: double.parse(priceProductController.text),
                            categoryGuid: selectedCategoryGUID!,
                            description: descriptionProductController.text,
                            guid: widget.preFillProduct!.guid);
                        Navigator.pop(context);
                        ref.read(productsProvider.notifier).edit(editProduct);
                      } else {
                        final newProduct = Product(
                            name: addProductController.text,
                            price: double.parse(priceProductController.text),
                            categoryGuid: selectedCategoryGUID!,
                            description: descriptionProductController.text,
                            guid: const Uuid().v4());
                        Navigator.pop(context);
                        ref.read(productsProvider.notifier).add(newProduct);
                      }
                    }
                  },
                  child: Text(context.l10n.saveCategoryLabel)),
            ],
          ),
        ),
      ),
    );
  }
}
