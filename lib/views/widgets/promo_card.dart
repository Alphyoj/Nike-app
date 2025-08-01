import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OverlayProductCard extends StatelessWidget {
  final String imageAsset;
  final String subtitle;
  final String title;
  final String buttonText;
  final double buttonWidth;

  const OverlayProductCard({
    super.key,
    required this.imageAsset,
    required this.subtitle,
    required this.title,
    required this.buttonText,
    required this.buttonWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 289,
      height: 384,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white, width: 1),
        image: DecorationImage(
          image: AssetImage(imageAsset),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Gradient overlay
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(250, 248, 248, 0), 
                  Color.fromRGBO(30, 10, 60, 0.3),
                  Color.fromRGBO(30, 10, 60, 0.8),
                ],
                stops: [0.0, 0.2467, 0.5753],
              ),
            ),
          ),

          // Subtitle
          Positioned(
            top: 230,
            left: 25,
            child: Text(
              subtitle,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                height: 1.0,
              ),
            ),
          ),

          // Title
          Positioned(
            top: 259,
            left: 25,
            child: SizedBox(
              width: 252,
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  height: 1.0,
                ),
              ),
            ),
          ),

          // Button
          Positioned(
            top: 325,
            left: 25,
            child: Container(
              height: 34,
              width: buttonWidth,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.0),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Center(
                child: Text(
                  buttonText,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    height: 1.0,
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
