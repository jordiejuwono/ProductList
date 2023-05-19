import 'package:flutter/material.dart';
import 'package:product_list/common/constants.dart';
import 'package:product_list/domain/entities/product_table.dart';
import 'package:product_list/presentation/screen/cart/provider/cart_notifier.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  static const routeName = "/cart-page";
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CartNotifier>(context, listen: false).getProductCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Your Cart",
            style: kHeading6,
          ),
        ),
        body: Consumer<CartNotifier>(builder: (context, value, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: value.cartProducts.length,
                    itemBuilder: (context, index) {
                      final currentItem = value.cartProducts[index];
                      bool isClickable = currentItem.total >= 2;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
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
                                    currentItem.thumbnail,
                                    width: 100,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentItem.title,
                                        style: kTextMediumBold,
                                      ),
                                      Text(currentItem.brand),
                                      Text("\$ ${currentItem.price}"),
                                      Row(
                                        children: [
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              if (isClickable) {
                                                value.subtractTotalItemAndPrice(
                                                    ProductTable(
                                                        id: currentItem.id,
                                                        title:
                                                            currentItem.title,
                                                        description: currentItem
                                                            .description,
                                                        price:
                                                            currentItem.price,
                                                        brand:
                                                            currentItem.brand,
                                                        category: currentItem
                                                            .category,
                                                        thumbnail: currentItem
                                                            .thumbnail,
                                                        total:
                                                            (currentItem.total -
                                                                1)));
                                              }
                                            },
                                            child: Card(
                                              color: isClickable
                                                  ? Colors.blue
                                                  : Colors.grey,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12.0),
                                                child: Text(
                                                  "-",
                                                  style:
                                                      kTextMediumBold.copyWith(
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
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0),
                                              child: Text(
                                                currentItem.total.toString(),
                                                style: kTextMediumBold.copyWith(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              value.addTotalItemAndPrice(
                                                  ProductTable(
                                                      id: value
                                                          .cartProducts[index]
                                                          .id,
                                                      title: value
                                                          .cartProducts[index]
                                                          .title,
                                                      description: value
                                                          .cartProducts[index]
                                                          .description,
                                                      price: value
                                                          .cartProducts[index]
                                                          .price,
                                                      brand: value
                                                          .cartProducts[index]
                                                          .brand,
                                                      category: value
                                                          .cartProducts[index]
                                                          .category,
                                                      thumbnail: value
                                                          .cartProducts[index]
                                                          .thumbnail,
                                                      total: (value
                                                              .cartProducts[
                                                                  index]
                                                              .total +
                                                          1)));
                                            },
                                            child: Card(
                                              color: Colors.blue,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12.0),
                                                child: Text(
                                                  "+",
                                                  style:
                                                      kTextMediumBold.copyWith(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(
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
                    }),
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Total : \$ ${value.totalPrice}",
                          style: kHeading6,
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                onPressed: () {},
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Text(
                                    "Checkout",
                                    style: kTextMediumBold,
                                  ),
                                )))
                      ],
                    ),
                  ))
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}
