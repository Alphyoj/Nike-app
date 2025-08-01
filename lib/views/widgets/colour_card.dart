import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColourCard extends StatelessWidget {
  final String imageAssetPath;
  final String categoryName;

  const ColourCard({
    Key? key,
    required this.imageAssetPath,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 166,
      height: 133,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(imageAssetPath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Stack(
        children: [
         
          Positioned(
            bottom: 12,
            left: 12,
            child: Text(
              categoryName,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
