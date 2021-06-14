import 'package:flutter/material.dart';

import 'Product.dart';

class Cart {
  final Product product;
  final int numOfItem;
  final int color;

  Cart({@required this.product, this.color, @required this.numOfItem});

  @override
  bool operator ==(Object other) {
    if (other is Cart) {
      return this.product.id == other.product.id &&
          this.color == other.color &&
          this.numOfItem == other.numOfItem;
    }
    return super == other;
  }

  @override
  int get hashCode => this.product.id.hashCode;
}
