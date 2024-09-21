import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/products/models/product.dart';

final selectedProductProvider = StateProvider<Product?>((ref) => null);
