import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String orderId;
  final DocumentReference uid;
  final DocumentReference delivery;
  final DateTime date;
  final int total;
  final List<Item> items;

  Order({this.orderId, this.uid, this.delivery, this.date, this.total, this.items});

  factory Order.fromDoc(DocumentSnapshot doc) {
    final data = doc.data();
    if (data == null) {
      return null;
    } else {
      return Order(
          orderId: doc.id,
          uid: doc['uid'],
          delivery: doc['delivery'],
          date: getDate(doc['date']),
          total: doc['total'],
          items: getItemList(doc['items']));
    }
  }

  static getDate(data) {
    if (data == null || !(data is Timestamp)) {
      return null;
    } else {
      return (data as Timestamp).toDate();
    }
  }

  static getItemList(data) {
    if (data == null) {
      return [];
    } else {
      return (data as List)
          .map((e) =>
          Item(
              pid: e['pid'],
              color: e['color'],
              price: e['price'],
              quantity: e['quantity'],
              pName: e['pname']
          ))
          .toList();
    }
  }
}

class Item {
  final DocumentReference pid;
  final int color;
  final String pName;
  final int price;
  final int quantity;

  Item({this.pName, this.pid, this.color, this.price, this.quantity});
}
