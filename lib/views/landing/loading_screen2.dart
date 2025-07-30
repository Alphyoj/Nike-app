import 'package:flutter/material.dart';
import 'package:nike_app/views/signup/signup_hi_screen.dart';
import 'dart:async';



class NikeLandingScreen extends StatefulWidget {
  const NikeLandingScreen({super.key});

  @override
  State<NikeLandingScreen> createState() => _NikeLandingScreenState();
}

class _NikeLandingScreenState extends State<NikeLandingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

   
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), 
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );

    _controller.forward(); 

  
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1000),
          pageBuilder: (_, __, ___) => const SignupSuccessScreen1(),
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF130329),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 114,
                height: 114,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
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
      ),
    );
  }
}
