import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:planthut/componets/coustom_bottom_nav_bar.dart';
import 'package:planthut/enums.dart';
import 'package:planthut/models/Cart.dart';
import 'package:planthut/models/Product.dart';
import 'package:planthut/screens/home/componets/body.dart';
import 'package:planthut/screens/profile/components/body.dart';
import 'package:progress_dialog/progress_dialog.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MenuState currentScreen = MenuState.home;
  Set<Cart> cartItems = Set();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar:
          CustomBottomNavBar(selectedMenu: currentScreen, onItemClick: onItemClick),
    );
  }

  onItemClick(MenuState menuState) {
    setState(() {
      currentScreen = menuState;
    });
  }

  Widget getBody() {
    if (currentScreen == MenuState.home) {
      return HomeBody(
          onItemAddToCart: onItemAddToCart,
          cartItems: cartItems,
          onCartRemove: onItemRemoveFromCart,
          onCheckout: onCheckout);
    } else {
      return ProfileBody();
    }
  }

  onItemAddToCart(Product product, int color, int quantity) async {
    cartItems.removeWhere((element) => element.product.id == product.id);
    cartItems.add(Cart(product: product, color: color, numOfItem: quantity));
    Fluttertoast.showToast(msg: "Added to cart");
  }

  onItemRemoveFromCart(Cart cart) async {
    setState(() {
      cartItems.remove(cart);
      Fluttertoast.showToast(msg: "Removed to cart");
    });
  }

  void onCheckout() async {
    try {
      if (cartItems.isEmpty) {
        Fluttertoast.showToast(msg: "No items to order");
      } else {
        final progress = ProgressDialog(context);
        progress.show();
        await FirebaseFirestore.instance.collection("orders").add({
          'date': Timestamp.now(),
          'total': getTotal(),
          'uid': getUser(),
          'items': getMap(),
          'delivery': null
        }).then((value) {
          setState(() {
            cartItems.clear();
            Fluttertoast.showToast(msg: "Order placed");
          });
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  getTotal() {
    int total = 0;
    cartItems.forEach((element) {
      total = total + (element.product.price * element.numOfItem);
    });
    return total;
  }

  getMap() {
    return cartItems.map((e) {
      return {
        'color': e.color,
        'price': e.product.price,
        'quantity': e.numOfItem,
        'pname': e.product.title,
        'pid': FirebaseFirestore.instance.collection("products").doc(e.product.id)
      };
    }).toList();
  }

  getUser() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid);
  }
}
