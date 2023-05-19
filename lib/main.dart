import 'package:flutter/material.dart';
import 'package:product_list/common/constants.dart';
import 'package:product_list/di/dependency.dart' as di;
import 'package:product_list/di/dependency.dart';
import 'package:product_list/presentation/screen/cart/provider/cart_notifier.dart';
import 'package:product_list/presentation/screen/cart/ui/cart_page.dart';
import 'package:product_list/presentation/screen/product_list/provider/product_list_notifier.dart';
import 'package:product_list/presentation/screen/product_list/ui/product_list_page.dart';
import 'package:product_list/presentation/screen/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const ProductApp());
}

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Product List App",
      theme: ThemeData(
        textTheme: kThemeText,
      ),
      home: const SplashScreen(),
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
                          editProductUseCase: locator(),
                          deleteProductUseCase: locator()),
                      child: const CartPage(),
                    ));
          default:
            return MaterialPageRoute(
                builder: (_) => const Center(
                      child: Text("Invalid Page"),
                    ));
        }
      },
    );
  }
}
