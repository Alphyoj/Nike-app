import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_app/utils/app_colors.dart';

class SimpleProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;

  const SimpleProductCard({
    super.key,
    required this.imageUrl,
    required this.productName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 130,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 167, 166, 166),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Full Image
            Positioned.fill(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Icon(Icons.broken_image)),
              ),
            ),
            // Bottom Text Overlay
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                color: Colors.transparent,
                child: Text(
                  productName,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
