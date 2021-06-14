import 'package:flutter/material.dart';
import 'package:planthut/componets/rounded_icon_btn.dart';
import 'package:planthut/models/Product.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ColorDots extends StatefulWidget {
  const ColorDots(
      {Key key, @required this.product, this.onSelectColor, this.quantity, this.onQuantityChange})
      : super(key: key);

  final Product product;
  final int quantity;
  final Function(int) onSelectColor;
  final Function(int) onQuantityChange;

  @override
  _ColorDotsState createState() => _ColorDotsState();
}

class _ColorDotsState extends State<ColorDots> {
  int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          ...List.generate(
            widget.product.colors.length,
            (index) => InkWell(
              onTap: () {
                setState(() {
                  selectedColor = index;
                  widget.onSelectColor(selectedColor);
                });
              },
              child: ColorDot(
                color: Color(widget.product.colors[index]),
                isSelected: index == selectedColor,
              ),
            ),
          ),
          Spacer(),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child:
                  Text(widget.quantity.toString(), style: Theme.of(context).textTheme.headline6)),
          RoundedIconBtn(
            icon: Icons.remove,
            press: () {
              widget.onQuantityChange(widget.quantity - 1);
            },
          ),
          SizedBox(width: getProportionateScreenWidth(20)),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: () {
              widget.onQuantityChange(widget.quantity + 1);
            },
          ),
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key key,
    @required this.color,
    this.isSelected = false,
  }) : super(key: key);

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2),
      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
