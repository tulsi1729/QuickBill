import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Bill'**
  String get appTitle;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardTitle;

  /// No description provided for @customersLabel.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get customersLabel;

  /// No description provided for @viewCustomersTitle.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get viewCustomersTitle;

  /// No description provided for @addCustomerTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Customer'**
  String get addCustomerTitle;

  /// No description provided for @editCustomerTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Customer'**
  String get editCustomerTitle;

  /// No description provided for @saveCustomerLabel.
  ///
  /// In en, this message translates to:
  /// **'Save Customer'**
  String get saveCustomerLabel;

  /// No description provided for @customerNameRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter customer name'**
  String get customerNameRequiredMessage;

  /// No description provided for @customerLabelRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter Customer Name'**
  String get customerLabelRequiredMessage;

  /// No description provided for @categoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryLabel;

  /// No description provided for @viewCategoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get viewCategoriesTitle;

  /// No description provided for @addCategoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Category'**
  String get addCategoryTitle;

  /// No description provided for @categoryLabelRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter Category Name'**
  String get categoryLabelRequiredMessage;

  /// No description provided for @saveCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Save Product'**
  String get saveCategoryLabel;

  /// No description provided for @categoryNameRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter category name'**
  String get categoryNameRequiredMessage;

  /// No description provided for @categoryRequiredMessageDelete.
  ///
  /// In en, this message translates to:
  /// **'Category is deleted'**
  String get categoryRequiredMessageDelete;

  /// No description provided for @categoryRequiredMessageNotDelete.
  ///
  /// In en, this message translates to:
  /// **'Category not deleted'**
  String get categoryRequiredMessageNotDelete;

  /// No description provided for @customerRequiredMessageDelete.
  ///
  /// In en, this message translates to:
  /// **'Customer is deleted'**
  String get customerRequiredMessageDelete;

  /// No description provided for @customerRequiredMessageNotDelete.
  ///
  /// In en, this message translates to:
  /// **'Customer not deleted'**
  String get customerRequiredMessageNotDelete;

  /// No description provided for @productLabel.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get productLabel;

  /// No description provided for @addProductTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get addProductTitle;

  /// No description provided for @viewProductTitle.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get viewProductTitle;

  /// No description provided for @productNameLabelRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter Product Name'**
  String get productNameLabelRequiredMessage;

  /// No description provided for @productDescriptionLabelRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter Product Description'**
  String get productDescriptionLabelRequiredMessage;

  /// No description provided for @productCategoryLabelRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter Product category'**
  String get productCategoryLabelRequiredMessage;

  /// No description provided for @productPriceLabelRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter Product Price'**
  String get productPriceLabelRequiredMessage;

  /// No description provided for @productIsDeletedMessage.
  ///
  /// In en, this message translates to:
  /// **'Product is Deleted'**
  String get productIsDeletedMessage;

  /// No description provided for @productNotDeletedMessage.
  ///
  /// In en, this message translates to:
  /// **'Product not Deleted'**
  String get productNotDeletedMessage;

  /// No description provided for @editProductTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Product'**
  String get editProductTitle;

  /// No description provided for @productNameRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter product name'**
  String get productNameRequiredMessage;

  /// No description provided for @productPriceRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter product price'**
  String get productPriceRequiredMessage;

  /// No description provided for @productCategorySelectedMessage.
  ///
  /// In en, this message translates to:
  /// **'Select category'**
  String get productCategorySelectedMessage;

  /// No description provided for @productCategorySelectedLabelMessage.
  ///
  /// In en, this message translates to:
  /// **' Select category'**
  String get productCategorySelectedLabelMessage;

  /// No description provided for @noProductMessage.
  ///
  /// In en, this message translates to:
  /// **'No Products'**
  String get noProductMessage;

  /// No description provided for @noCategoryMessage.
  ///
  /// In en, this message translates to:
  /// **'No Categories'**
  String get noCategoryMessage;

  /// No description provided for @noCustomerMessage.
  ///
  /// In en, this message translates to:
  /// **'No Customer'**
  String get noCustomerMessage;

  /// No description provided for @entryLabel.
  ///
  /// In en, this message translates to:
  /// **'Entry'**
  String get entryLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
