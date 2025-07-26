import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/CartController.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: scheme.onSurface,
      ),
      
      extendBodyBehindAppBar: false,
      
      body: SafeArea(
        child: Obx(() {
          if (cart.items.isEmpty) {
            return _EmptyCart();
          }
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
               
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 12,
                    bottom: 0,
                  ),
                  itemCount: cart.items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) {
                    final ci = cart.items[i];
                    return _CartItemCard(cartItem: ci);
                  },
                ),
              ),
              _CheckoutBar(total: cart.total),
            ],
          );
        }),
      ),
    );
  }
}


class _EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 120,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Add something delicious!',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}


class _CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  const _CartItemCard({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Dismissible(
      key: Key(cartItem.food.name),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.redAccent.withOpacity(.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.redAccent),
      ),
      onDismissed: (_) {
        Get.find<CartController>().remove(cartItem.food);
        Get.snackbar(
          'Removed',
          '${cartItem.food.name} removed from cart',
          snackPosition: SnackPosition.TOP,
        );
      },
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: scheme.surface.withOpacity(.9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  cartItem.food.imagePath,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItem.food.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '\$${cartItem.food.price.toStringAsFixed(2)} each',
                      style: TextStyle(
                        fontSize: 13,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: Colors.redAccent,
                    ),
                    onPressed: () {
                      final removed = cartItem.quantity == 1;
                      Get.find<CartController>().remove(cartItem.food);
                      if (removed) {
                        Get.snackbar(
                          'Removed',
                          '${cartItem.food.name} removed from cart',
                          snackPosition: SnackPosition.TOP,
                        );
                      } else {
                        Get.snackbar(
                          'Updated',
                          'Quantity decreased',
                          snackPosition: SnackPosition.TOP,
                        );
                      }
                    },
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      '${cartItem.quantity}',
                      key: ValueKey<int>(cartItem.quantity),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: Colors.green,
                    ),
                    onPressed: () =>
                        Get.find<CartController>().add(cartItem.food),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _CheckoutBar extends StatelessWidget {
  final double total;
  const _CheckoutBar({required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Total',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.white),
                ),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.shopping_bag_outlined),
            label: const Text('Checkout'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            ),
            onPressed: () {
              Get.snackbar('Checkout', 'Proceeding to payment...');
            },
          ),
        ],
      ),
    );
  }
}
