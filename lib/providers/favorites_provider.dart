import 'package:flutter/material.dart';
import 'package:nike_app/model/product.dart';
import 'package:nike_app/services/favorites_db_helper.dart';

class FavoritesProvider extends ChangeNotifier {
  List<Product> _favorites = [];

  List<Product> get favorites => _favorites;

  FavoritesProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    _favorites = await FavoritesDatabase.instance.getFavorites();
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return _favorites.any((item) => item.id == product.id);
  }

  Future<void> toggleFavorite(Product product) async {
    final isFav = isFavorite(product);

    if (isFav) {
      await FavoritesDatabase.instance.deleteFavorite(product.id);
      _favorites.removeWhere((item) => item.id == product.id);
    } else {
      await FavoritesDatabase.instance.insertFavorite(product);
      _favorites.add(product);
    }

    notifyListeners();
  }
}
