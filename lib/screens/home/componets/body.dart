import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:planthut/models/Cart.dart';
import 'package:planthut/models/Product.dart';

import '../../../size_config.dart';
import 'home_header.dart';
import 'popular_product.dart';

class HomeBody extends StatefulWidget {
  final Function(Product, int, int) onItemAddToCart;
  final Set<Cart> cartItems;
  final Function(Cart) onCartRemove;
  final VoidCallback onCheckout;

  const HomeBody(
      {Key key, this.onItemAddToCart, this.cartItems, this.onCartRemove, this.onCheckout})
      : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String searchQuery = "";
  List<Product> fullList = [];
  List<Product> currentList = [];
  Timer _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("products").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          fullList = snapshot.data.docs.map((e) => Product.fromDoc(e)).toList();
          if (searchQuery.isEmpty) {
            currentList = fullList;
          }
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getProportionateScreenHeight(20)),
                HomeHeader(
                  query: searchQuery,
                  onSearch: onSearch,
                  cartItems: widget.cartItems,
                  onCartRemove: widget.onCartRemove,
                  onCheckout: widget.onCheckout,
                ),
                SizedBox(height: getProportionateScreenWidth(30)),
                Expanded(
                    child:
                        Products(products: currentList, onItemAddToCart: widget.onItemAddToCart)),
              ],
            ),
          );
        });
  }

  onSearch(String query) {
    if (_debounce?.isActive ?? false) {
      _debounce.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        searchQuery = query;
        currentList = fullList
            .where((element) => element.title.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();
      });
    });
  }
}
