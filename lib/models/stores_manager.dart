import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wonderful_ties/models/store.dart';

class StoresManager extends ChangeNotifier{

  List<Store> stores;

  StoresManager(){
    _loadStoreList();
  }

  final Firestore firestore = Firestore.instance;

  Future<void> _loadStoreList() async {
    final snapshot = await firestore.collection('stores').getDocuments();
    stores = snapshot.documents.map((e) => Store.fromDocument(e)).toList();
    notifyListeners();
  }
}