import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:planthut/models/Product.dart';
import 'package:planthut/screens/details/details_screen.dart';

import '../constants.dart';
import '../size_config.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    @required this.product,
    this.onItemAddToCart,
  }) : super(key: key);

  final Product product;
  final Function(Product, int, int) onItemAddToCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          DetailsScreen.routeName,
          arguments: ProductDetailsArguments(product: product, onItemAddToCart: onItemAddToCart),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                child: Hero(
                  tag: product.id.toString(),
                  child: Image.network(
                    product.images[0],
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Image.asset("assets/images/bottom_img_1.png"),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                product.title,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, left: 10),
              child: Text(
                "₹${product.price}",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
