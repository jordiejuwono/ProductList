import 'package:flutter/material.dart';
import 'package:product_list/common/request_state.dart';
import 'package:product_list/common/use_case.dart';
import 'package:product_list/domain/entities/product_list.dart';
import 'package:product_list/domain/entities/product_table.dart';
import 'package:product_list/domain/usecase/fetch_product_list_use_case.dart';
import 'package:product_list/domain/usecase/insert_cart_use_case.dart';

class ProductListNotifier extends ChangeNotifier {
  final FetchProductListUseCase fetchProductListUseCase;
  final InsertCartUseCase insertCartUseCase;
  ProductListNotifier({
    required this.fetchProductListUseCase,
    required this.insertCartUseCase,
  });

  RequestState _fetchListState = RequestState.loading;
  RequestState get fetchListState => _fetchListState;

  RequestState _addToCartState = RequestState.loading;
  RequestState get addToCartState => _addToCartState;

  List<Product> _productList = [];
  List<Product> get productList => _productList;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  void filterProduct(double fromPrice, double toPrice) {
    _productList = _productList.where((element) => element.price < 50).toList();
    notifyListeners();
  }

  Future<void> fetchProductList() async {
    _fetchListState = RequestState.loading;
    notifyListeners();

    final result = await fetchProductListUseCase.call(const NoParams());
    result.fold((failure) {
      _errorMessage = failure.errorMessage;
      _fetchListState = RequestState.error;
      notifyListeners();
    }, (result) {
      _productList.addAll(result.products);
      _fetchListState = RequestState.loaded;
      notifyListeners();
    });
  }

  Future<void> addToCart(ProductTable product) async {
    final result = await insertCartUseCase.call(product);
    result.fold((failure) {
      _errorMessage = failure.errorMessage;
      _addToCartState = RequestState.error;
      notifyListeners();
    }, (result) {
      _addToCartState = RequestState.loaded;
      notifyListeners();
    });
  }
}
