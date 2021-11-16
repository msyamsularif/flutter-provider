import 'package:example_provider/providers/all_products.dart';
import 'package:example_provider/providers/cart.dart';
import 'package:example_provider/screens/cart_screen.dart';
import 'package:example_provider/widgets/badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context)!.settings.arguments as String; // is the id!
    final product = Provider.of<Products>(context).findById(productId);
    final cart = Provider.of<Cart>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          Consumer<Cart>(
            builder: (context, value, ch) => Badge(
              child: ch ?? const Text("Null"),
              value: value.countItems.toString(),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 250,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            product.title,
            style: const TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "\$${product.price}",
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            product.description,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 30),
          OutlinedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Add to cart sucessfully"),
                  duration: Duration(milliseconds: 500),
                ),
              );

              cart.addCart(
                product.id,
                product.title,
                product.price,
              );
            },
            child: const Text(
              "Add to cart",
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
