import 'package:flutter/material.dart';
import 'package:nike_app/utils/app_colors.dart';
import 'package:nike_app/views/splash/splash3.dart';
import 'package:nike_app/views/splash/splash4.dart';

class HiNikeSplash2 extends StatelessWidget {
  const HiNikeSplash2({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    const baseWidth = 375.0;
    const baseHeight = 812.0;

    double scaleX(double px) => screenWidth * (px / baseWidth);
    double scaleY(double px) => screenHeight * (px / baseHeight);

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
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
                color: AppColors.white,
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          ),

          Positioned(
            top: scaleY(110),
            left: scaleX(20),
            child: SizedBox(
              width: scaleX(320),
              height: scaleY(84),
              child: const Text(
                "Which products do\nyou use the most?",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  height: 1.0,
                  color: AppColors.white,
                ),
              ),
            ),
          ),

          _optionRow(
            top: 282,
            imagePath: 'lib/assets/men.jpg',
            label: "Men's",
            textColor: AppColors.hintText,
            scaleX: scaleX,
            scaleY: scaleY,
          ),
          Positioned(
            top: scaleY(345),
            left: scaleX(20),
            child: Container(
              width: scaleX(318),
              height: scaleY(1),
              color: AppColors.hintText,
            ),
          ),
          _optionRow(
            top: 361,
            imagePath: 'lib/assets/women.jpg',
            label: "Women's",
            textColor: AppColors.hintText,
            scaleX: scaleX,
            scaleY: scaleY,
          ),
          Positioned(
            top: scaleY(449),
            left: scaleX(27),
            child: const Text(
              "Any others?",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: AppColors.hintText,
              ),
            ),
          ),
          _optionRow(
            top: 525,
            imagePath: 'lib/assets/boy.jpg',
            label: "Boys'",
            textColor: AppColors.hintText,
            scaleX: scaleX,
            scaleY: scaleY,
          ),
          Positioned(
            top: scaleY(588),
            left: scaleX(20),
            child: Container(
              width: scaleX(318),
              height: scaleY(1),
              color: AppColors.hintText,
            ),
          ),
          _optionRow(
            top: 604,
            imagePath: 'lib/assets/girl.jpg',
            label: "Girls'",
            textColor: AppColors.hintText,
            scaleX: scaleX,
            scaleY: scaleY,
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
                    pageBuilder: (_, __, ___) => const HiNikeSplash3(),
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
                  color: AppColors.white,
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

  Widget _optionRow({
    required double top,
    required String imagePath,
    required String label,
    required Color textColor,
    required double Function(double) scaleX,
    required double Function(double) scaleY,
  }) {
    return Positioned(
      top: scaleY(top),
      left: scaleX(20),
      child: SizedBox(
        width: scaleX(320),
        height: scaleY(60),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                imagePath,
                width: scaleX(48),
                height: scaleY(48),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: scaleX(18)),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
            ),
            const Spacer(),
            Container(
              width: scaleX(22),
              height: scaleY(22),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.hintText, width: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
