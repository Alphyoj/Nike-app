import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_app/utils/app_colors.dart';

class ArchiveCard2 extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String subtitle;
  final bool isNetwork;

  const ArchiveCard2({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.subtitle,
    this.isNetwork = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: isNetwork
                ? Image.network(
                    imageAsset,
                    width: 160,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    imageAsset,
                    width: 160,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.hintText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.background,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
