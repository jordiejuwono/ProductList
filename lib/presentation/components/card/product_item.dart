import 'package:flutter/material.dart';
import 'package:product_list/common/constants.dart';

class ProductItem extends StatelessWidget {
  final String productName;
  final String brand;
  final String price;
  final String imageUrl;
  final VoidCallback addToCart;
  const ProductItem({
    super.key,
    required this.productName,
    required this.brand,
    required this.price,
    required this.imageUrl,
    required this.addToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            12.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imageUrl,
                  width: 100,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: kTextMediumBold,
                    ),
                    Text(brand),
                    Text("\$ $price"),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                          onPressed: addToCart,
                          child: Text(
                            "Add to Cart",
                            style: kTextMediumMediumBold,
                          )),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
