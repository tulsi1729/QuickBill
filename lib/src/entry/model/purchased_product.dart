class PurchasedProduct {
  final String customerGuid;
  final String productName;
  final int quantity;
  final int productPrice;
  const PurchasedProduct(
      {required this.customerGuid,
      required this.productName,
      required this.quantity,
      required this.productPrice});
}
