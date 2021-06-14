import 'package:flutter/material.dart';
import 'package:planthut/componets/default_button.dart';
import 'package:planthut/models/Product.dart';
import 'package:planthut/screens/details/componets/color_dart.dart';
import 'package:planthut/screens/details/componets/products_image.dart';

import '../../../size_config.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';

class Body extends StatefulWidget {
  final Product product;
  final Function(Product, int, int) onItemAddToCart;

  const Body({Key key, @required this.product, this.onItemAddToCart}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int selectedColor = 0;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImages(product: widget.product),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductDescription(
                  product: widget.product,
                ),
                TopRoundedContainer(
                  color: Color(0xFFF6F7F9),
                  child: Column(
                    children: [
                      ColorDots(
                          product: widget.product,
                          onSelectColor: onSelectColor,
                          quantity: quantity,
                          onQuantityChange: onQuantityChange),
                      TopRoundedContainer(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.15,
                            right: SizeConfig.screenWidth * 0.15,
                            bottom: getProportionateScreenWidth(40),
                            top: getProportionateScreenWidth(15),
                          ),
                          child: DefaultButton(
                            text: "Add To Cart",
                            press: () {
                              widget.onItemAddToCart(
                                  widget.product, widget.product.colors[selectedColor], quantity);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  onSelectColor(int color) {
    selectedColor = color;
  }

  onQuantityChange(int newQuantity) {
    setState(() {
      if (newQuantity > 0) {
        quantity = newQuantity;
      }
    });
  }
}
