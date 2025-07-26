import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/CartController.dart';
import '../controller/MainPageController.dart';
import '../views/Cart.dart';

class MainPage extends GetView<MainPageController> {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final cart = Get.find<CartController>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Menu'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: scheme.onPrimary,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [scheme.primary, scheme.primaryContainer],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          Obx(() {
            final count = cart.items.fold<int>(0, (s, e) => s + e.quantity);
            return Badge(
              label: Text('$count'),
              isLabelVisible: count > 0,
              child: IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () => Get.to(() => const CartPage()),
              ),
            );
          }),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, kToolbarHeight + 32, 16, 16),
        itemCount: controller.menu.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final item = controller.menu[index];
          return _FoodCard(item: item);
        },
      ),
    );
  }
}

class _FoodCard extends StatelessWidget {
  final FoodItem item;
  const _FoodCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final cart = Get.find<CartController>();

    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: scheme.surface,
        ),
        child: Row(
          children: [
            // Hero Image
            Hero(
              tag: item.name,
              child: ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(20),
                ),
                child: Image.asset(
                  item.imagePath,
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Info & Actions
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: scheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Add/Remove column
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    final qty =
                        cart.items
                            .firstWhereOrNull((e) => e.food.name == item.name)
                            ?.quantity ??
                        0;
                    return Column(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.remove_circle_outline,
                            color: Colors.redAccent,
                          ),
                          onPressed: () => cart.remove(item),
                        ),
                        Badge(
                          backgroundColor: scheme.primary,
                          label: Text('$qty'),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.add_circle_outline,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            cart.add(item);
                            Get.snackbar(
                              'Added',
                              '${item.name} added to cart',
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: scheme.primaryContainer,
                              colorText: scheme.onPrimaryContainer,
                            );
                          },
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
