import 'package:flutter/material.dart';
import 'package:planthut/models/Cart.dart';

class CartArgs {
  final Set<Cart> cartItems;
  final Function(Cart) onRemoveCallback;
  final VoidCallback onCheckout;

  CartArgs(this.cartItems, this.onRemoveCallback, this.onCheckout);
}
