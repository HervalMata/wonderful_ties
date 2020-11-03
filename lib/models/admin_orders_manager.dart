import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:wonderful_ties/models/order.dart';
import 'package:wonderful_ties/models/user.dart';

class AdminOrdersManager extends ChangeNotifier{
  List<Order> _orders = [];
  User userFilter;
  final Firestore firestore = Firestore.instance;
  StreamSubscription _subscription;

  void updateAdmin({bool adminEnabled}){
    _orders.clear();
    _subscription?.cancel();
    if(adminEnabled){
      _listenToOrders();
    }
  }

  List<Order> get fiteredOrders{
    List<Order> output = _orders.reversed.toList();
    if(userFilter != null){
      output = output.where((o) => o.userId == userFilter.id).toList();
    }
    return output;
  }

  void _listenToOrders() {
    _subscription = firestore.collection('orders')
        .snapshots().listen((event) {
      for(final change in event.documentChanges){
        switch(change.type){
          case DocumentChangeType.added:
            _orders.add(
                    Order.fromDocument(change.document)
            );
            break;
          case DocumentChangeType.modified:
            final modOrder = _orders.firstWhere(
                    (o) => o.orderId == change.document.documentID);
            break;
          case DocumentChangeType.removed:
            debugPrint('Deu um erro muito grave!');
            break;
        }

      }
      notifyListeners();
    });
  }

  void setUserFilter(User user){
    userFilter = user;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}