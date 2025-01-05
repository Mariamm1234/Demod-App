import 'package:demod/models/cart.dart';
import 'package:demod/models/product.dart';
import 'package:demod/providers/cartProviser.dart';
import 'package:demod/providers/userProviser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatelessWidget {
  final ProductDto product;
  const ProductTile({super.key, required this.product});
  void addToCart(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Add this item to cart?"),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          MaterialButton(
            onPressed: () async {
              Navigator.pop(context);
              final data = Cart(id: product.id, email: authProvider.email);
              //cart provider
              final cartProvide =
                  Provider.of<CartProvider>(context, listen: false);
              await cartProvide.addToCart(data);
              if (cartProvide.done) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added to cart")),
                );
                cartProvide.done = false;
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Not added")),
                );
              }
            },
            child: Text("Add"),
          )
        ],
      ),
    );
  }

  void removeFromCart(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(" Remove this item from cart?"),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          MaterialButton(
            onPressed: () async {
              Navigator.pop(context);
              //cart provider
              final cartProvide =
                  Provider.of<CartProvider>(context, listen: false);
              await cartProvide.removeFromCart(product.id, authProvider.email);
              if (cartProvide.removed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Removed from cart")),
                );
                cartProvide.removed = false;
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Not Removed")),
                );
              }
            },
            child: Text("Remove"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(25),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //image
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  child: const Icon(Icons.favorite),
                ),
              ),
              const SizedBox(height: 25),
              //name
              Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              //description
              Text(
                product.description,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          //price+add
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${product.price.toStringAsFixed(2)}'),
//add to cart
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12)),
                child: IconButton(
                    onPressed: () => addToCart(context), icon: Icon(Icons.add)),
              ),

              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12)),
                child: IconButton(
                    onPressed: () => removeFromCart(context),
                    icon: Icon(Icons.remove)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
