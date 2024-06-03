import 'package:flutter/material.dart';
import 'package:quick_bill/src/categories/presentation/view_categories.dart';
import 'package:quick_bill/src/customers/presentation/view_customers.dart';
import 'package:quick_bill/src/localization/app_localizations_context.dart';
import 'package:quick_bill/src/products/presentation/view_products.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final keys = ["customers", "category", "product"];
    final Map<String, Widget Function(BuildContext)> items = {
      "customers": (context) => const ViewCustomers(),
      "category": (context) => const ViewCategories(),
      "product": (context) => const ViewProducts(),
    };
    final Map<String, String> titlesMap = {
      "customers": context.l10n.customersLabel,
      "category": context.l10n.categoryLabel,
      "product": context.l10n.productLabel,
    };
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.dashboardTitle),
        elevation: 5,
      ),
      body: ListView.separated(
        itemCount: keys.length,
        separatorBuilder: (_, __) {
          return const SizedBox(
            height: 10,
          );
        },
        itemBuilder: (context, index) {
          final key = keys.elementAt(index);
          return ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder:
                          items[key] ?? (context) => const Text("Not Found")),
                );
              },
              child: Text(
                titlesMap[key] ?? "",
                style: const TextStyle(fontSize: 20),
              ));
        },
      ),
    );
  }
}
