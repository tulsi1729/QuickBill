import 'package:flutter/material.dart';
import 'package:quick_bill/src/customers/presentation/view_customers.dart';
import 'package:quick_bill/src/localization/app_localizations_context.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, Type> items = {
      "customers": ViewCustomers,
    };
    final Map<String, String> titlesMap = {
      "customers": context.l10n.customersLabel,
    };
    final keys = items.keys;
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
                      builder: (context) => const ViewCustomers()),
                );
              },
              child: Text(titlesMap[key] ?? ""));
        },
      ),
    );
  }
}
