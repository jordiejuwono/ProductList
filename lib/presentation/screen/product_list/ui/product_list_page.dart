import 'package:flutter/material.dart';
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
  RangeValues _rangeValues = const RangeValues(1, 1800);

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProductListNotifier>(context, listen: false)
          .fetchProductList();
    });
  }

  void showFilterDialog(ChangeNotifier notifier) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Filter Price (\$)",
              style: kTextMediumBold,
            ),
            content: Consumer<ProductListNotifier>(
              builder: (context, value, child) {
                return RangeSlider(
                    values: const RangeValues(1, 1800),
                    onChanged: (values) {
                      value.filterProduct(values.start, values.end);
                    });
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductListNotifier>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "List Product",
            style: kHeading6,
          ),
          actions: [
            _showFilterDialog(context, provider),
            _showCartPage(context)
          ],
        ),
        body: Consumer<ProductListNotifier>(
          builder: (context, value, child) {
            if (value.fetchListState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (value.fetchListState == RequestState.empty) {
              return Center(
                child: Text(
                  "No Products found",
                  style: kHeading5.copyWith(color: Colors.grey.shade400),
                  textAlign: TextAlign.center,
                ),
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

  IconButton _showCartPage(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, CartPage.routeName);
        },
        icon: const Icon(Icons.shopping_cart_rounded));
  }

  IconButton _showFilterDialog(
      BuildContext context, ProductListNotifier provider) {
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (dialogContext) {
                return StatefulBuilder(builder: (statefulContext, dialogState) {
                  return AlertDialog(
                    title: Text(
                      "Filter Price (\$)",
                      style: kTextMediumBold,
                    ),
                    content: SizedBox(
                      height: 100.0,
                      child: Column(
                        children: [
                          RangeSlider(
                              min: 1,
                              max: 1800,
                              values: _rangeValues,
                              divisions: 10,
                              onChanged: (values) {
                                setState(() {
                                  _rangeValues = values;
                                });
                                dialogState(() {
                                  _rangeValues = values;
                                });
                                // Provider.of<ProductListNotifier>(context,
                                //         listen: false)
                                //     .filterProduct(values.start, values.end);
                              }),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                Text("\$ ${_rangeValues.start.toInt()}"),
                                const Spacer(),
                                Text("\$ ${_rangeValues.end.toInt()}"),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              dialogState(() {
                                _rangeValues = const RangeValues(1, 1800);
                              });
                            });
                          },
                          child: Text(
                            "Reset Filter",
                            style: kTextMediumBold,
                          )),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(statefulContext);

                            provider.filterProduct(
                                _rangeValues.start, _rangeValues.end);
                          },
                          child: Text(
                            "Apply Filter",
                            style: kTextMediumBold,
                          ))
                    ],
                  );
                });
              });
        },
        icon: const Icon(Icons.filter_alt));
  }
}
