import 'package:flutter/material.dart';
import 'package:nike_app/utils/app_colors.dart';
import 'package:nike_app/views/splash/splash4.dart';

class HiNikeSplash3 extends StatelessWidget {
  const HiNikeSplash3({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    const baseWidth = 375.0;
    const baseHeight = 812.0;

    double scaleX(double px) => screenWidth * (px / baseWidth);
    double scaleY(double px) => screenHeight * (px / baseHeight);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/assets/splash.jpg',
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.5),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: scaleY(65),
            left: scaleX(81),
            child: Container(
              width: scaleX(199),
              height: scaleY(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          ),

          Positioned(
            top: scaleY(110),
            left: scaleX(20),
            child: SizedBox(
              width: scaleX(335),
              height: scaleY(294),
              child: Text(
                'Want to use location\nServices to help you\nfind the closest Nike\nStore, access in-store\nand location-based\nfeatures, and see\nexperiences near you?',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 38,
                  fontWeight: FontWeight.w400,
                  height: 1.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          Positioned(
            top: scaleY(721),
            left: scaleX(111),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 300),
                    pageBuilder: (_, __, ___) => const HiNikeSplash4(),
                    transitionsBuilder: (_, anim, __, child) {
                      return FadeTransition(opacity: anim, child: child);
                    },
                  ),
                );
              },
              child: Container(
                width: scaleX(153),
                height: scaleY(43),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
