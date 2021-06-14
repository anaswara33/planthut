import 'package:flutter/material.dart';
import 'package:planthut/screens/details/componets/body.dart';
import 'package:planthut/screens/details/componets/custom_app_bar.dart';

import '../../models/Product.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: CustomAppBar(rating: agrs.product.rating),
      body: Body(product: agrs.product, onItemAddToCart: agrs.onItemAddToCart),
    );
  }
}

class ProductDetailsArguments {
  final Product product;
  final Function(Product, int, int) onItemAddToCart;

  ProductDetailsArguments({this.onItemAddToCart, @required this.product});
}
