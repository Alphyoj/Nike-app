import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nike_app/model/product.dart';

class ApiService {
  static const String _mensShoesUrl = 'https://dummyjson.com/products/category/mens-shoes';
  static const String _womensShoesUrl = 'https://dummyjson.com/products/category/womens-shoes';
  static const String _kidsShoesUrl = 'https://dummyjson.com/products/category/tops'; 

  static Future<List<Product>> fetchShoes() async {
    final mensResponse = await http.get(Uri.parse(_mensShoesUrl));
    final womensResponse = await http.get(Uri.parse(_womensShoesUrl));
    final kidsResponse = await http.get(Uri.parse(_kidsShoesUrl));

    if (mensResponse.statusCode == 200 &&
        womensResponse.statusCode == 200 &&
        kidsResponse.statusCode == 200) {
      
      final mensData = jsonDecode(mensResponse.body);
      final womensData = jsonDecode(womensResponse.body);
      final kidsData = jsonDecode(kidsResponse.body);

      final List mensProducts = mensData['products'];
      final List womensProducts = womensData['products'];
      final List kidsProducts = kidsData['products'];

      return [
        ...mensProducts.map((json) => Product.fromJson(json)),
        ...womensProducts.map((json) => Product.fromJson(json)),
        ...kidsProducts.map((json) => Product.fromJson(json)),
      ];
    } else {
      throw Exception('Failed to load shoes');
    }
  }
}
