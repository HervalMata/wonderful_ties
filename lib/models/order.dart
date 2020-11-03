import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wonderful_ties/models/address.dart';
import 'package:wonderful_ties/models/cart_manager.dart';
import 'package:wonderful_ties/models/cart_product.dart';

enum Status { cancelled, preparing, transporting, delivered }

class Order {
  List<CartProduct> items;
  num price;
  String userId;
  Address address;
  String orderId;
  Timestamp date;
  Status status;

  String get formattedId => '#${orderId.padLeft(6, '0')}';

  Order.fromCartManager(CartManager cartManager){
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.user.id;
    address = cartManager.address;
    status = Status.preparing;
  }

  final Firestore firestore = Firestore.instance;
  DocumentReference get firestoreRef =>
    firestore.collection('orders').document(orderId);

  void updateFromDocument(DocumentSnapshot doc){
    status = Status.values[doc.data['status'] as int];
  }

  Future<void> save() async {
    firestore.collection('orders').document(orderId).setData(
      {
        'items': items.map((e) => e.toOrderItemMap()).toList(),
        'price': price,
        'user': userId,
        'address': address.toMap(),
        'status': status.index,
        'date': Timestamp.now(),
      }
    );
  }

  Order.fromDocument(DocumentSnapshot doc) {
    orderId = doc.documentID;
    items = (doc.data['items'] as List<dynamic>).map((e) {
      return CartProduct.fromMap(e as Map<String, dynamic>);
    }).toList();
    price = doc.data['price'] as num;
    userId = doc.data['user'] as String;
    address = Address.fromMap(doc.data['address'] as Map<String, dynamic>);
    date = doc.data['date'] as Timestamp;
    status = Status.values[doc.data['status'] as int];
  }

  String get statusText => getStatusText(status);

  @override
  String toString() {
    return 'Order{items: $items, price: $price, userId: $userId, address: $address, orderId: $orderId, date: $date, firestore: $firestore}';
  }

  static String getStatusText(Status status) {
    switch(status){
      case Status.cancelled:
        return 'Cancelado';
      case Status.preparing:
        return 'Em preparação';
      case Status.transporting:
        return 'Em transporte';
      case Status.delivered:
        return 'Entregue';
      default:
        return '';
    }
  }

  Function() get back {
    return status.index >= Status.transporting.index ?
    (){
      status = Status.values[status.index - 1];
      firestoreRef.updateData(
        {'status': status.index}
      );
    } : null;
  }

  Function() get advance {
    return status.index <= Status.transporting.index ?
        (){
      status = Status.values[status.index + 1];
      firestoreRef.updateData(
          {'status': status.index}
      );
    } : null;
  }

  void cancel(){
    status = Status.cancelled;
    firestoreRef.updateData({'status': status.index});
  }
}