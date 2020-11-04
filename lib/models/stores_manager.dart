import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wonderful_ties/models/store.dart';

class StoresManager extends ChangeNotifier{

  List<Store> stores;
  Timer _timer;

  StoresManager(){
    _loadStoreList();
    _starTime();
  }

  final Firestore firestore = Firestore.instance;

  Future<void> _loadStoreList() async {
    final snapshot = await firestore.collection('stores').getDocuments();
    stores = snapshot.documents.map((e) => Store.fromDocument(e)).toList();
    notifyListeners();
  }

  void _starTime() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkOpening();
    });
  }

  void _checkOpening() {
    for(final store in stores)
      store.updateStatus();
      notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}