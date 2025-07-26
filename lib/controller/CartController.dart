import 'package:get/get.dart';
import '../controller/MainPageController.dart';   // for FoodItem

class CartItem {
  final FoodItem food;
  int quantity;
  CartItem(this.food, this.quantity);
}

class CartController extends GetxController {
  final _items = <String, CartItem>{}.obs;   // key: food.name

  List<CartItem> get items => _items.values.toList();
  double get total =>
      _items.values.fold(0, (sum, e) => sum + e.food.price * e.quantity);

  void add(FoodItem food) {
    if (_items.containsKey(food.name)) {
      _items[food.name]!.quantity++;
    } else {
      _items[food.name] = CartItem(food, 1);
    }
    _items.refresh();
  }

  void remove(FoodItem food) {
    final item = _items[food.name];
    if (item == null) return;
    item.quantity--;
    if (item.quantity == 0) _items.remove(food.name);
    _items.refresh();
  }
}