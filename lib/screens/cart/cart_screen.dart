import 'package:flutter/material.dart';
import 'package:planthut/models/Cart.dart';
import 'package:planthut/screens/cart/components/check_out.dart';

import 'components/body.dart';
import 'components/cart_args.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as CartArgs;
    return Scaffold(
      appBar: buildAppBar(context, args.cartItems.length),
      body:
          Body(cartItems: args.cartItems.toList(), removeCallback: (cart) => onRemove(cart, args)),
      bottomNavigationBar:
          CheckoutCard(total: getTotal(args.cartItems), onCheckout: () => onCheckout(args)),
    );
  }

  AppBar buildAppBar(BuildContext context, int length) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "$length items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }

  getTotal(Set<Cart> args) {
    int total = 0;
    args.forEach((element) {
      total = total + (element.product.price * element.numOfItem);
    });
    return total;
  }

  onRemove(Cart cart, CartArgs args) {
    setState(() {
      args.cartItems.remove(cart);
      args.onRemoveCallback(cart);
    });
  }

  void onCheckout(CartArgs args) {
    Navigator.of(context).pop();
    args.onCheckout();
  }
}
