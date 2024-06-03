import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_bill/src/common/constants/string_constants.dart';

class DatabaseClient<Entity> {
  final CollectionReference<Map<String, dynamic>> _collection;
  final String _collectionName;
  final Entity Function(Map<String, dynamic>) _fromMap;
  DatabaseClient(
    String collectionName,
    final Entity Function(Map<String, dynamic>) fromMap,
  )   : _fromMap = fromMap,
        _collectionName = collectionName,
        _collection = FirebaseFirestore.instance.collection(collectionName);

  /// Invoke to Insert Entity
  Future<void> insert({required entityJSON}) async {
    _collection.add(entityJSON);
  }

  /// Invoke to Edit Entity by GUID
  Future<void> editByGUID(
      {required String guid,
      required Map<String, dynamic> updatedEntityMap}) async {
    final QuerySnapshot querySnapshot = await _collection
        .where(StringConstants.guid, isEqualTo: guid)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final String documentId = querySnapshot.docs.first.id;
      await _collection.doc(documentId).update(updatedEntityMap);
    } else {
      throw Exception(
          'No Entity found with GUID: $guid in $_collectionName collection.');
    }
  }

  /// Invoke to Delete Entity by GUID
  Future<void> deleteByGUID({required String guid}) async {
    final QuerySnapshot querySnapshot = await _collection
        .where(StringConstants.guid, isEqualTo: guid)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final String documentId = querySnapshot.docs.first.id;
      await _collection.doc(documentId).delete();
    } else {
      throw Exception(
          'No Entity found with GUID: $guid in $_collectionName collection.');
    }
  }

  /// Invoke to Get All Entities
  Future<List<Entity>> getAllEntities() async {
    final QuerySnapshot querySnapshot = await _collection.get();

    return querySnapshot.docs
        .map((doc) => _fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
