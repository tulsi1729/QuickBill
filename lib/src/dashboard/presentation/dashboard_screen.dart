import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/categories/presentation/view_categories.dart';
import 'package:quick_bill/src/customers/presentation/view_customers.dart';
import 'package:quick_bill/src/products/presentation/view_products.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
// final keys = ["customers", "category", "product"];
  // final Map<String, Widget Function(BuildContext)> items = {
  //   "customers": (context) => const ViewCustomers(),
  //   "category": (context) => const ViewCategories(),
  //   "product": (context) => const ViewProducts(),
  // };
  // final Map<String, String> titlesMap = {
  //   "customers": context.l10n.customersLabel,
  //   "category": context.l10n.categoryLabel,
  //   "product": context.l10n.productLabel,
  // };

  int currentPageIndex = 0;
  static const List<Widget> _widgetOption = <Widget>[
    ViewCustomers(),
    ViewProducts(),
    ViewCategories()
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        body: Center(
          child: _widgetOption.elementAt(currentPageIndex),
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
                selectedIcon: Icon(Icons.person),
                icon: Icon(Icons.person_outline),
                label: "Customers"),
            NavigationDestination(
                selectedIcon: Icon(Icons.production_quantity_limits),
                icon: Icon(Icons.production_quantity_limits),
                label: "Products"),
            NavigationDestination(
                selectedIcon: Icon(Icons.category_outlined),
                icon: Icon(Icons.category_outlined),
                label: "Categories"),
          ],
        ),
      ),
    );
  }
}
