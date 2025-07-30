import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_app/views/landing/loading_screen2.dart';

class SignupSuccessScreen extends StatelessWidget {
  const SignupSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Nike Logo
          Positioned(
            top: 99,
            left: 20,
            child: Image.asset(
              'lib/assets/nike_black.png',
              width: 41,
              height: 14,
            ),
          ),

          // Jordan Logo
          Positioned(
            top: 89,
            left: 71,
            child: Image.asset(
              'lib/assets/jordan.png',
              width: 37,
              height: 34,
            ),
          ),

          // Success Text
          Positioned(
            top: 164,
            left: 20,
            child: SizedBox(
              width: 320,
              height: 72,
              child: Text(
                "You have been signed in successfully.",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  color: const Color(0xFF130329),
                ),
              ),
            ),
          ),

          // Continue Button
          Positioned(
            top: 297,
            left: 237,
            child: SizedBox(
              width: 106,
              height: 36,
              child: ElevatedButton(
                onPressed: () {
                  
 Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const NikeLandingScreen(),
    ),
  );
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF130329),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: Center(
                  child: Text(
                    "Continue",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      height: 1.0,
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
