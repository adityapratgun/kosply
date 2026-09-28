import 'package:flutter/foundation.dart';

import '../models/product.dart';

/// Global state untuk daftar produk favorit.
///
/// Ini yang membuat fitur favorit "nyambung" ke semua screen: begitu
/// [toggleFavorite] dipanggil dari Home ATAU dari Product Detail,
/// [notifyListeners] akan membuat Favorite Screen (dan kartu produk di
/// screen lain yang menampilkan produk yang sama) otomatis rebuild dengan
/// state terbaru - tanpa perlu passing data manual antar screen.
class FavoriteProvider extends ChangeNotifier {
  final List<Product> _favorites = [];

  List<Product> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(Product product) {
    return _favorites.any((p) => p.id == product.id);
  }

  void toggleFavorite(Product product) {
    if (isFavorite(product)) {
      _favorites.removeWhere((p) => p.id == product.id);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }

  void removeFavorite(Product product) {
    _favorites.removeWhere((p) => p.id == product.id);
    notifyListeners();
  }
}
