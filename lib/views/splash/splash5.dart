import 'package:flutter/material.dart';
import 'package:nike_app/views/screens/home_screen.dart';


class HiNikeSplash5 extends StatefulWidget {
  const HiNikeSplash5({super.key});

  @override
  State<HiNikeSplash5> createState() => _HiNikeSplash5State();
}

class _HiNikeSplash5State extends State<HiNikeSplash5> with SingleTickerProviderStateMixin {
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
      curve: Curves.easeInOut,
    );

    _controller.forward();

    
    Future.delayed(const Duration(milliseconds: 1100), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeIn,
              ),
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
