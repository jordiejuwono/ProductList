import 'package:flutter/material.dart';
import 'package:product_list/common/request_state.dart';
import 'package:product_list/common/use_case.dart';
import 'package:product_list/domain/entities/product_list.dart';
import 'package:product_list/domain/entities/product_table.dart';
import 'package:product_list/domain/usecase/edit_product_use_case.dart';
import 'package:product_list/domain/usecase/fetch_product_cart_use_case.dart';

class CartNotifier extends ChangeNotifier {
  final FetchProductCartUseCase fetchProductCartUseCase;
  final EditProductUseCase editProductUseCase;

  CartNotifier({
    required this.fetchProductCartUseCase,
    required this.editProductUseCase,
  });

  RequestState _cartState = RequestState.loading;
  RequestState get cartState => _cartState;

  RequestState _editState = RequestState.loading;
  RequestState get editState => _editState;

  List<ProductTable> _cartProducts = [];
  List<ProductTable> get cartProducts => _cartProducts;

  int _totalPrice = 0;
  int get totalPrice => _totalPrice;

  int _totalItem = 0;
  int get totalItem => _totalItem;

  void addTotalItemAndPrice(ProductTable product) {
    _totalPrice += product.price;
    _totalItem += product.total;
    editProduct(product);
  }

  void subtractTotalItemAndPrice(ProductTable product) {
    _totalPrice -= product.price;
    _totalItem -= product.total;
    editProduct(product);
  }

  Future<void> editProduct(ProductTable product) async {
    _editState = RequestState.loading;
    notifyListeners();

    final result = await editProductUseCase.call(product);

    result.fold((failure) {
      _editState = RequestState.error;
      notifyListeners();
    }, (result) {
      _editState = RequestState.loaded;
      getUpdatedCart();
    });
  }

  Future<void> getUpdatedCart() async {
    final result = await fetchProductCartUseCase.call(const NoParams());

    result.fold((failure) {
      _cartState = RequestState.error;
      notifyListeners();
    }, (result) {
      _cartProducts = result;
      _cartState = RequestState.loaded;
      notifyListeners();
    });
  }

  Future<void> getProductCart() async {
    _cartState = RequestState.loading;
    notifyListeners();

    final result = await fetchProductCartUseCase.call(const NoParams());

    result.fold((failure) {
      _cartState = RequestState.error;
      notifyListeners();
    }, (result) {
      _cartProducts = result;
      for (var element in _cartProducts) {
        _totalPrice += element.price;
        _totalItem += element.total;
      }
      _cartState = RequestState.loaded;
      notifyListeners();
    });
  }
}
