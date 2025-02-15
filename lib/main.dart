import 'package:demod/pages/cart_page.dart';
import 'package:demod/pages/login.dart';
import 'package:demod/pages/shop_page.dart';
import 'package:demod/providers/cartProviser.dart';
import 'package:demod/providers/productProvider.dart';
import 'package:demod/providers/userProviser.dart';
import 'package:demod/themes/light.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/intro.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Intro(),
      theme: lightMode,
      routes: {
        '/login': (context) => const Login(),
        '/intro': (context) => const Intro(),
        '/shop_page': (context) => const ShopPage(),
        '/cart_page': (context) => const CartPage(),
      },
    );
  }
}
