import 'package:flutter/material.dart';
import 'package:product_list/domain/entities/product_table.dart';
import 'package:product_list/presentation/cart/ui/cart_page.dart';
import 'package:product_list/presentation/product_list/provider/product_list_notifier.dart';
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
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, CartPage.routeName);
              },
              child: Icon(Icons.abc))
        ],
      ),
      body: Consumer<ProductListNotifier>(
        builder: (context, value, child) {
          return ListView.builder(
              itemCount: value.productList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    value.addToCart(ProductTable(
                      id: value.productList[index].id,
                      title: value.productList[index].title,
                      description: value.productList[index].description,
                      price: value.productList[index].price,
                      brand: value.productList[index].brand,
                      category: value.productList[index].category,
                      thumbnail: value.productList[index].thumbnail,
                      total: 1,
                    ));
                  },
                  title: Text(value.productList[index].title),
                );
              });
        },
      ),
    );
  }
}
