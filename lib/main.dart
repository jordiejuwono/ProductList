import 'package:flutter/material.dart';
import 'package:product_list/di/dependency.dart' as di;
import 'package:product_list/di/dependency.dart';
import 'package:product_list/presentation/cart/provider/cart_notifier.dart';
import 'package:product_list/presentation/cart/ui/cart_page.dart';
import 'package:product_list/presentation/product_list/provider/product_list_notifier.dart';
import 'package:product_list/presentation/product_list/ui/product_list_page.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const ProductApp());
}

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Product List App",
      home: ChangeNotifierProvider(
          create: (_) => ProductListNotifier(
              fetchProductListUseCase: locator(), insertCartUseCase: locator()),
          child: const ProductListPage()),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case ProductListPage.routeName:
            return MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider(
                    create: (_) => ProductListNotifier(
                        fetchProductListUseCase: locator(),
                        insertCartUseCase: locator()),
                    child: const ProductListPage()));
          case CartPage.routeName:
            return MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider(
                      create: (_) => CartNotifier(
                          fetchProductCartUseCase: locator(),
                          editProductUseCase: locator()),
                      child: const CartPage(),
                    ));
          default:
        }
      },
    );
  }
}
