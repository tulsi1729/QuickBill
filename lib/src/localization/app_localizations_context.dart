import 'package:flutter/widgets.dart';
import 'package:quick_bill/src/localization/app_localizations.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
