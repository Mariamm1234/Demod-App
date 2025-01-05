import 'package:demod/components/my_drawer.dart';
import 'package:demod/components/product_tile.dart';
import 'package:demod/providers/productProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatelessWidget{
  const ShopPage({super.key});
    static const routeName = '/shop_page';

  Future<void> _fetchProducts(BuildContext context) {
    return Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }


  @override
  Widget build(BuildContext context) {

  
return Scaffold(
  appBar: AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    foregroundColor: Theme.of(context).colorScheme.inversePrimary,
    title: const Text("Shop page"),
  ),
  drawer: const MyDrawer(),
  backgroundColor: Theme.of(context).colorScheme.surface,
  body:  FutureBuilder<void>(
        future: _fetchProducts(context),  // Calling the Future function
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show loading indicator while waiting for data
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Show error message if there was an issue fetching data
            return Center(child: Text('An error occurred: ${snapshot.error}'));
          } else if (snapshot.connectionState == ConnectionState.done) {
            // Once data is fetched, display the products
            final products = Provider.of<ProductProvider>(context).products;

            if (products.isEmpty) {
              return Center(child: Text('No products available.'));
            }
            return ListView(
              children: [
                const SizedBox(height: 25),
                Center(
                  child: Text("All products",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary
                  ),
                  ),
                ),

                  SizedBox(
            height:550,
            child:ListView.builder(
              itemCount: products.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(15) ,
              itemBuilder: (context,index){
                final product =products[index];

                return ProductTile(product: product);
              }
              
              )),
              ],
            );
          
 }
 // Default return (should never reach here)
          return Center(child: Text('Unexpected error occurred.'));
 }
      ),
    );
  }
}