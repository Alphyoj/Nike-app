import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SportCategoryCard extends StatelessWidget {
  final String imageAssetPath;
  final String categoryName;

  const SportCategoryCard({
    Key? key,
    required this.imageAssetPath,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 109.33,
      height: 150,
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
            bottom: 10,
            left: 10,
            child: SizedBox(
              width: 65,
              height: 16,
              child: Text(
                categoryName,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  height: 1.0,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
