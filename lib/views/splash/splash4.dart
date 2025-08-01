import 'package:flutter/material.dart';
import 'package:nike_app/utils/app_colors.dart';
import 'package:nike_app/views/splash/splash5.dart';

class HiNikeSplash4 extends StatelessWidget {
  const HiNikeSplash4({super.key});

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
              color: const Color(0x99130329),
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
              height: scaleY(126),
              child: const Text(
                "Get personalised ads by enabling app tracking",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  height: 1.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          Positioned(
            top: scaleY(284),
            left: scaleX(20),
            child: SizedBox(
              width: scaleX(335),
              height: scaleY(42),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/nike_logo_white.png',
                    width: scaleX(27),
                    height: scaleY(11),
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: scaleX(8)),
                  Expanded(
                    child: const Text(
                      "Get personalised Nike ads on partner platforms based on your app activity",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: scaleY(356),
            left: scaleX(20),
            child: SizedBox(
              width: scaleX(335),
              height: scaleY(63),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'lib/assets/Group 774.png',
                    width: scaleX(24),
                    height: scaleX(24),
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: scaleX(12)),
                  Expanded(
                    child: const Text(
                      "On the next prompt, if you select \"Ask App Not to Track\", you may see less relevant Nike ads.",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: scaleY(459),
            left: scaleX(20),
            child: GestureDetector(
              onTap: () {
              
              },
              child: const Text(
                "Learn more",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.0,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),

          Positioned(
            top: scaleY(543),
            left: scaleX(20),
            child: SizedBox(
              width: scaleX(335),
              child: const Text(
                "On iOS, your permission is required to track your activity on this app on this device. This can be updated at any time from your device settings",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          Positioned(
            bottom: scaleY(60),
            left: scaleX(111),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 300),
                    pageBuilder: (_, __, ___) => const HiNikeSplash5(),
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
                    "Next",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: AppColors.backgroundDark,
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
