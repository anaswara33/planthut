import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planthut/models/Product.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Hero(
            tag: widget.product.id.toString(),
            child: Image.network(
              widget.product.images[selectedImage],
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Image.asset("assets/images/bottom_img_1.png"),
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Container(
          height: getProportionateScreenWidth(48),
          child: ListView.builder(
            padding: EdgeInsets.only(left: 20),
            scrollDirection: Axis.horizontal,
            itemCount: widget.product.images.length,
            itemBuilder: (context, index) {
              return buildSmallProductPreview(index);
            },
          ),
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
          duration: defaultDuration,
          margin: EdgeInsets.only(right: 15),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
          ),
          child: Image.network(
            widget.product.images[index],
            fit: BoxFit.cover,
            filterQuality: FilterQuality.low,
            errorBuilder: (_, __, ___) => Image.asset("assets/images/bottom_img_1.png"),
          )),
    );
  }
}
