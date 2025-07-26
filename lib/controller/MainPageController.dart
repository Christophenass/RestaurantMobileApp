import 'package:get/get.dart';

class FoodItem {
  final String name;
  final double price;
  final String imagePath;

  FoodItem(this.name, this.price, this.imagePath);
}

class MainPageController extends GetxController {
  // Static list – never changes
  final List<FoodItem> menu = [
    FoodItem('Classic Burger', 5.99, 'images/burger.jpg'),
    FoodItem('Pepperoni Pizza', 8.49, 'images/pizza.jpg'),
    FoodItem('Caesar Salad', 4.25, 'images/caesar_salad.jpg'),
    FoodItem('Cheese Quesadilla', 6.25, 'images/quesadilla_cheese.jpg'),
    FoodItem('Grilled Salmon', 12.90, 'images/grilled_salmon.jpg'),
    FoodItem('Chicken Wings', 7.99, 'images/chicken_wings.jpg'),
    FoodItem('Veggie Wrap', 5.50, 'images/veggie_wrap.jpg'),
    FoodItem('Beef Tacos', 6.75, 'images/beef_tacos.jpg'),
    FoodItem('Margherita Pizza', 7.99, 'images/margherita_pizza.jpg'),
    FoodItem('Pasta Alfredo', 9.25, 'images/pasta_alfredo.jpg'),
    FoodItem('Greek Salad', 4.75, 'images/greek_salad.jpg'),
    FoodItem('Chocolate Cake', 3.50, 'images/chocolate_cake.jpg'),
    FoodItem('Fresh Juice', 2.99, 'images/fresh_juice.jpg'),
  ];
}
