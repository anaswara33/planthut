import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title, description;
  final List<String> images;
  final List<int> colors;
  final int rating, price;

  Product({
    @required this.id,
    @required this.images,
    @required this.colors,
    this.rating = 0,
    @required this.title,
    @required this.price,
    @required this.description,
  });

  factory Product.fromDoc(DocumentSnapshot doc) {
    final data = doc.data();
    if (data == null) {
      return null;
    } else {
      return Product(
        id: doc.id,
        title: doc['title'],
        description: doc['description'],
        rating: doc['rating'],
        price: doc['price'],
        images: getList<String>(doc['images']),
        colors: getList<int>(doc['colors']),
      );
    }
  }
}

getList<T>(json) {
  if (json == null) {
    return [];
  } else {
    return (json as List).map((e) => e as T).toList();
  }
}
