import 'package:example_provider/providers/cart.dart';
import 'package:example_provider/providers/product.dart';
import 'package:example_provider/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: productData.id,
            );
          },
          child: Image.network(
            productData.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (context, value, child) => IconButton(
              icon: (value.isFavorite)
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border_outlined),
              color: Colors.amber,
              onPressed: () {
                value.statusFav();
              },
            ),
          ),
          title: Text(
            productData.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Add to cart sucessfully"),
                  duration: Duration(milliseconds: 500),
                ),
              );

              cart.addCart(
                productData.id,
                productData.title,
                productData.price,
              );
            },
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
