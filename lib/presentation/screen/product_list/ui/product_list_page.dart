import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:product_list/common/constants.dart';
import 'package:product_list/common/request_state.dart';
import 'package:product_list/domain/entities/product_table.dart';
import 'package:product_list/presentation/components/card/product_item.dart';
import 'package:product_list/presentation/screen/cart/ui/cart_page.dart';
import 'package:product_list/presentation/screen/product_list/provider/product_list_notifier.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  static const routeName = "/product-list";
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProductListNotifier>(context, listen: false)
          .fetchProductList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "List Product",
            style: kHeading6,
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.filter_alt)),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, CartPage.routeName);
                },
                icon: const Icon(Icons.shopping_cart_rounded))
          ],
        ),
        body: Consumer<ProductListNotifier>(
          builder: (context, value, child) {
            if (value.fetchListState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
                itemCount: value.productList.length,
                itemBuilder: (context, index) {
                  final currentItem = value.productList[index];
                  return ProductItem(
                      productName: currentItem.title,
                      brand: currentItem.brand,
                      price: currentItem.price.toString(),
                      imageUrl: currentItem.thumbnail,
                      addToCart: () {
                        value.addToCart(ProductTable(
                          id: currentItem.id,
                          title: currentItem.title,
                          description: currentItem.description,
                          price: currentItem.price,
                          brand: currentItem.brand,
                          category: currentItem.category,
                          thumbnail: currentItem.thumbnail,
                          total: 1,
                        ));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Add ${currentItem.title} to Cart successful!"),
                          action: SnackBarAction(
                              label: "Check",
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, CartPage.routeName);
                              }),
                        ));
                      });
                });
          },
        ),
      ),
    );
  }
}
