import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nike_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'package:nike_app/providers/favorites_provider.dart';
import 'package:nike_app/views/landing/landing_screen.dart';
import 'package:nike_app/views/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // Handle Firebase init error
    debugPrint("Firebase Initialization Error: $e");
  }

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nike App',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          fontFamily: 'Poppins',
        ),
        home: const HomeScreen(), 
      ),
    );
  }
}