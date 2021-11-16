import 'package:example_provider/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Total : \$${cartData.totalPrice}",
                style: const TextStyle(
                  fontSize: 35,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartData.items?.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(cartData.items!.values.toList()[index].title),
                subtitle: Text(
                  "Quantity : ${cartData.items!.values.toList()[index].qty}",
                ),
                trailing: Text(
                  "\$${cartData.items!.values.toList()[index].qty * cartData.items!.values.toList()[index].price}",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
