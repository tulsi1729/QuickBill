import 'package:flutter/material.dart';
import 'package:quick_bill/src/localization/app_localizations_context.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.dashboardTitle),
        elevation: 5,
      ),
      body: const FlutterLogo(),
    );
  }
}
