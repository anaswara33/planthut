import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planthut/models/Cart.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  final List<Cart> cartItems;
  final Function(Cart) removeCallback;

  const Body({Key key, this.cartItems, this.removeCallback}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(widget.cartItems[index].product.id.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
                widget.removeCallback(widget.cartItems[index]);
            },
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: CartCard(cart: widget.cartItems[index]),
          ),
        ),
      ),
    );
  }
}
