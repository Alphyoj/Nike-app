import 'package:flutter/material.dart';
import 'package:nike_app/model/cart_item.dart';
import '../model/product.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

 
  void addToCart(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      _items[index] = CartItem(
        product: _items[index].product,
        quantity: _items[index].quantity + 1,
      );
    } else {
      _items.add(CartItem(product: product, quantity: 1));
    }

    notifyListeners();
  }


  void decreaseQuantity(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      final currentQuantity = _items[index].quantity;
      if (currentQuantity > 1) {
        _items[index] = CartItem(
          product: _items[index].product,
          quantity: currentQuantity - 1,
        );
      } else {
        _items.removeAt(index);
      }

      notifyListeners();
    }
  }

 
  void removeFromCart(Product product) {
    _items.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

 
  void updateQuantity(int index, int newQty) {
    if (index >= 0 && index < _items.length && newQty > 0) {
      _items[index] = CartItem(
        product: _items[index].product,
        quantity: newQty,
      );
      notifyListeners();
    } else if (newQty == 0) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  double get subtotal =>
      _items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));

 
  double get delivery => 50.00;


  double get total => subtotal + delivery;

 
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
