import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wonderful_ties/models/section.dart';

class HomeManager {
  List<Section> sections = [];

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
      print(sections);
    });
  }

}