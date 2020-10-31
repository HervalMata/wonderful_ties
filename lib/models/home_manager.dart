import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wonderful_ties/models/section.dart';

class HomeManager extends ChangeNotifier {
  List<Section> sections = [];

  bool editing = false;

  HomeManager(){
    _loadSections();
  }

  final Firestore firestore = Firestore.instance;

  Future<void> _loadSections() async {
    firestore.collection('home').snapshots().listen((snapshot) {
      sections.clear();
      for(final DocumentSnapshot document in snapshot.documents){
        sections.add(Section.fromDocument(document));
      }
      notifyListeners();
    });
  }

  void enterEditing(){
    editing = true;
    notifyListeners();
  }

  void saveEditing(){
    editing = false;
    notifyListeners();
  }

  void discardEditing(){
    editing = false;
    notifyListeners();
  }

}