import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nike_app/utils/app_colors.dart';
import 'package:nike_app/views/landing/welcome_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();


    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1000),
          pageBuilder: (_, __, ___) => const NikeWelcomeScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF130329), 
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
          
            SizedBox(
              width: 114,
              height: 114,
              child: CircularProgressIndicator(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                backgroundColor: Colors.white.withOpacity(0.2),
              ),
            ),
           
            Image.asset(
              'lib/assets/nike_logo_white.png', 
              width: 55,
              height: 20,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
