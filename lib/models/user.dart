import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wonderful_ties/models/address.dart';

class User {

  String id;
  String name;
  String email;
  String password;
  String confirmPassword;
  String cpf;
  bool admin = false;
  Address address;

  DocumentReference get firestoreRef => Firestore.instance.document('users/$id');
  CollectionReference get cartReference => firestoreRef.collection('cart');

  User({this.email, this.password, this.name, this.id});

  User.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;
    cpf = document.data['cpf'] as String;
    if(document.data.containsKey('address')){
      address = Address.fromMap(document.data['address'] as Map<String, dynamic>);
    }
  }

  Future<void> saveData() async {
    await firestoreRef.setData(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      if(address != null) 'address': address.toMap(),
      if(cpf != null) 'cpf': cpf,
    };
  }

  void setAddress(Address address){
    this.address = address;
    saveData();
  }

  void setCpf(String cpf){
    this.cpf = cpf;
    saveData();
  }
}