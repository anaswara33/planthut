import 'package:flutter/material.dart';
import 'package:planthut/models/Cart.dart';
import 'package:planthut/screens/cart/cart_screen.dart';
import 'package:planthut/screens/cart/components/cart_args.dart';

import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  final Function(String) onSearch;
  final Set<Cart> cartItems;
  final String query;
  final Function(Cart) onCartRemove;
  final VoidCallback onCheckout;

  const HomeHeader({
    Key key,
    this.onSearch,
    this.cartItems,
    this.query,
    this.onCartRemove,
    this.onCheckout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          Expanded(child: SearchField(query: query, onSearch: onSearch)),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            press: () => Navigator.pushNamed(context, CartScreen.routeName,
                arguments: CartArgs(cartItems, onCartRemove, onCheckout)),
          )
        ],
      ),
    );
  }
}
