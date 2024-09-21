class Entry {
  final String productName;
  final int quantity;
  final double productPrice;
  final String createdOn;
  final String customerGUID;
  const Entry({
    required this.productName,
    required this.quantity,
    required this.productPrice,
    required this.createdOn,
    required this.customerGUID,
  });
}
