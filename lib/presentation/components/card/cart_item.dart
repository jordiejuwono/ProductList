import 'package:flutter/material.dart';
import 'package:product_list/common/constants.dart';

class CartItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String brand;
  final String price;
  final bool isClickable;
  final String totalItem;
  final VoidCallback onSubtractClick;
  final VoidCallback onAddClick;
  final VoidCallback onDeleteClick;
  const CartItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.brand,
    required this.price,
    required this.isClickable,
    required this.totalItem,
    required this.onSubtractClick,
    required this.onAddClick,
    required this.onDeleteClick,
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
                      title,
                      style: kTextMediumBold,
                    ),
                    Text(brand),
                    Text("\$ $price"),
                    Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTap: onSubtractClick,
                          child: Card(
                            color: isClickable ? Colors.blue : Colors.grey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                "-",
                                style: kTextMediumBold.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          elevation: 2.0,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              totalItem,
                              style: kTextMediumBold.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: onAddClick,
                          child: Card(
                            color: Colors.blue,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                "+",
                                style: kTextMediumBold.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: onDeleteClick,
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    ),
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
