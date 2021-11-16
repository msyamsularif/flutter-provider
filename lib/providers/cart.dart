import 'package:example_provider/models/card_item.dart';
import 'package:flutter/cupertino.dart';

class Cart with ChangeNotifier {
  final Map<String, CardItem> _items = {};

  Map<String, CardItem>? get items => _items;

  int get countItems => (_items.isEmpty) ? 0 : _items.length;

  double get totalPrice {
    double total = 0.0;
    _items.forEach((key, value) {
      total += value.qty * value.price;
    });

    return total;
  }

  void addCart(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (value) => CardItem(
          id: value.id,
          title: value.title,
          price: value.price,
          qty: value.qty + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CardItem(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          title: title,
          price: price,
          qty: 1,
        ),
      );
    }

    notifyListeners();
  }
}
