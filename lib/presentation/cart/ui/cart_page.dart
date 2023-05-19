import 'package:flutter/material.dart';
import 'package:product_list/domain/entities/product_table.dart';
import 'package:product_list/presentation/cart/provider/cart_notifier.dart';
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
    return Scaffold(
      body: Consumer<CartNotifier>(builder: (context, value, child) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: value.cartProducts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(value.cartProducts[index].title),
                      subtitle: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              value.subtractTotalItemAndPrice(ProductTable(
                                  id: value.cartProducts[index].id,
                                  title: value.cartProducts[index].title,
                                  description:
                                      value.cartProducts[index].description,
                                  price: value.totalPrice,
                                  brand: value.cartProducts[index].brand,
                                  category: value.cartProducts[index].category,
                                  thumbnail:
                                      value.cartProducts[index].thumbnail,
                                  total:
                                      (value.cartProducts[index].total + 1)));
                            },
                            child: Card(
                              color: Colors.grey,
                              child: Text(
                                "-",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.grey,
                            child: Text(
                              value.cartProducts[index].total.toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              value.addTotalItemAndPrice(ProductTable(
                                  id: value.cartProducts[index].id,
                                  title: value.cartProducts[index].title,
                                  description:
                                      value.cartProducts[index].description,
                                  price: value.totalPrice,
                                  brand: value.cartProducts[index].brand,
                                  category: value.cartProducts[index].category,
                                  thumbnail:
                                      value.cartProducts[index].thumbnail,
                                  total:
                                      (value.cartProducts[index].total - 1)));
                            },
                            child: Card(
                              color: Colors.grey,
                              child: Text(
                                "+",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            Row(
              children: [Text(value.totalPrice.toString())],
            )
          ],
        );
      }),
    );
  }
}
