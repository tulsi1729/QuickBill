import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/src/common/constants/string_constants.dart';
import 'package:quick_bill/src/customers/models/customer.dart';

/// Provider to get customers repository
final customersRepositoryProvider = Provider((ref) {
  return CustomersRepository(FirebaseFirestore.instance);
});

class CustomersRepository {
  final FirebaseFirestore _firestore;
  CustomersRepository(FirebaseFirestore firestore) : _firestore = firestore;

  /// Invoke to Save Customer
  Future<void> save({required customerJSON}) async {
    _firestore
        .collection(StringConstants.customersCollectionName)
        .add(customerJSON);
  }

  /// Invoke to Edit Customer by GUID
  Future<void> editByGUID(
      {required String guid,
      required Map<String, dynamic> updatedCustomerMap}) async {
    final QuerySnapshot querySnapshot = await _firestore
        .collection(StringConstants.customersCollectionName)
        .where(StringConstants.guid, isEqualTo: guid)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final String documentId = querySnapshot.docs.first.id;
      await _firestore
          .collection(StringConstants.customersCollectionName)
          .doc(documentId)
          .update(updatedCustomerMap);
    } else {
      throw Exception('No customer found with GUID: $guid');
    }
  }

  /// Invoke to Delete Customer by GUID
  Future<void> deleteByGUID({required String guid}) async {
    final QuerySnapshot querySnapshot = await _firestore
        .collection(StringConstants.customersCollectionName)
        .where(StringConstants.guid, isEqualTo: guid)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final String documentId = querySnapshot.docs.first.id;
      await _firestore
          .collection(StringConstants.customersCollectionName)
          .doc(documentId)
          .delete();
    } else {
      throw Exception('No customer found with GUID: $guid');
    }
  }

  /// Invoke to Get All Customers
  Future<List<Customer>> getAllCustomers() async {
    final QuerySnapshot querySnapshot = await _firestore
        .collection(StringConstants.customersCollectionName)
        .get();

    return querySnapshot.docs
        .map((doc) => Customer.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
