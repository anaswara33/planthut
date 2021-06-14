import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planthut/componets/product_cart.dart';
import 'package:planthut/models/Product.dart';

import '../../../size_config.dart';

class Products extends StatelessWidget {
  final List<Product> products;
  final Function(Product, int, int) onItemAddToCart;

  const Products({Key key, this.products, this.onItemAddToCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            "Products",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Expanded(
          child: GridView.builder(
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return ProductCard(product: products[index],onItemAddToCart:onItemAddToCart);
            },
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(30)),
      ],
    );
  }
}
