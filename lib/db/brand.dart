import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class BrandService {
  Firestore _firestore = Firestore.instance;
  String ref = 'brands';

  void createBrand(String name) {
    var id = Uuid();
    String brandId = id.v1();

    _firestore.collection('brands').document(brandId).setData({'brand': name});
  }

  Future<List<DocumentSnapshot>> getBrands() async {
    return _firestore.collection(ref).getDocuments().then((snaps) {
      return snaps.documents;
    });
  }

  Future<List<DocumentSnapshot>> getSuggestions(String suggestion) async {
    await _firestore
        .collection(ref)
        .where('category', isEqualTo: suggestion)
        .getDocuments()
        .then((snap) {
      return snap.documents;
    });
  }
}
