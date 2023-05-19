import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:product_list/common/constants.dart';
import 'package:product_list/common/request_state.dart';
import 'package:product_list/domain/entities/product_table.dart';
import 'package:product_list/presentation/components/card/cart_item.dart';
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
          if (value.cartState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (value.cartState == RequestState.empty) {
            return Center(
              child: Text(
                "Your Cart is empty",
                style: kHeading5.copyWith(color: Colors.grey.shade400),
                textAlign: TextAlign.center,
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: value.cartProducts.length,
                    itemBuilder: (context, index) {
                      final currentItem = value.cartProducts[index];
                      bool isClickable = currentItem.total >= 2;
                      return CartItem(
                        imageUrl: currentItem.thumbnail,
                        title: currentItem.title,
                        brand: currentItem.brand,
                        price: currentItem.price.toString(),
                        isClickable: isClickable,
                        totalItem: currentItem.total.toString(),
                        onSubtractClick: () {
                          if (isClickable) {
                            value.subtractTotalItemAndPrice(ProductTable(
                                id: currentItem.id,
                                title: currentItem.title,
                                description: currentItem.description,
                                price: currentItem.price,
                                brand: currentItem.brand,
                                category: currentItem.category,
                                thumbnail: currentItem.thumbnail,
                                total: (currentItem.total - 1)));
                          }
                        },
                        onAddClick: () {
                          value.addTotalItemAndPrice(ProductTable(
                              id: currentItem.id,
                              title: currentItem.title,
                              description: currentItem.description,
                              price: currentItem.price,
                              brand: currentItem.brand,
                              category: currentItem.category,
                              thumbnail: currentItem.thumbnail,
                              total: (currentItem.total + 1)));
                        },
                        onDeleteClick: () {
                          value.deleteProductCart(ProductTable(
                            id: currentItem.id,
                            title: currentItem.title,
                            description: currentItem.description,
                            price: currentItem.price,
                            brand: currentItem.brand,
                            category: currentItem.category,
                            thumbnail: currentItem.thumbnail,
                            total: currentItem.total,
                          ));
                          Fluttertoast.showToast(
                              msg: "Removed ${currentItem.title} from Cart");
                        },
                      );
                    }),
              ),
              _checkOutButton(value, context)
            ],
          );
        }),
      ),
    );
  }

  Row _checkOutButton(CartNotifier value, BuildContext context) {
    return Row(
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
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          "Checkout",
                          style: kTextMediumBold,
                        ),
                      )))
            ],
          ),
        ))
      ],
    );
  }
}
