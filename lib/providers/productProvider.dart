
import 'dart:convert';

import 'package:demod/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
    List<ProductDto> _products = [];
    List<ProductDto> get products => [..._products];

      Future<void> fetchProducts() async {
    final url = Uri.parse('http://10.0.2.2:8080/api/products/allproducts');
    final response = await http.get(
      url
      // headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      _products = data.map((item) => ProductDto.fromJson(item)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to fetch products');
    }
  }

}