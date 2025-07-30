import 'package:flutter/material.dart';
import 'package:nike_app/utils/app_colors.dart';
import 'package:nike_app/views/splash/splash2.dart';

class HiNikeSplash1 extends StatelessWidget {
  const HiNikeSplash1({super.key});

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

          Positioned(
            top: scaleY(65),
            left: scaleX(81),
            child: Opacity(
              opacity: 1.0,
              child: Transform.rotate(
                angle: 0,
                child: Container(
                  width: scaleX(199),
                  height: scaleY(5),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
              ),
            ),
          ),

          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: scaleX(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: scaleY(110)),

                    SizedBox(
                      width: scaleX(320),
                      height: scaleY(126),
                      child: const Text(
                        "To personalise your experience and connect you to sport.",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 28,
                          color: AppColors.white,
                        ),
                      ),
                    ),

                    const Spacer(),

                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: const Duration(milliseconds: 300),
                              pageBuilder: (_, __, ___) => const HiNikeSplash2(),
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
                              "Get Started",
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

                    SizedBox(height: scaleY(50)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
