import 'package:flutter/material.dart';
import 'package:nike_app/utils/app_colors.dart'; // Ensure this path is correct

class CustomFooter extends StatelessWidget {
  final double screenWidth;

  const CustomFooter({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: 80, // Fixed height for the footer
      decoration: BoxDecoration(
        color: AppColors.white, // Footer background
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5), // Shadow at the top of the footer
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildFooterIcon(Icons.home_outlined, 45, true), // Home
          _buildFooterIcon(Icons.shopping_bag_outlined, 112), // Shopping Bag
          _buildFooterIcon(Icons.favorite_border, 177), // Heart
          _buildFooterIcon(Icons.shopping_cart_outlined, 244), // Cart
          _buildFooterIcon(Icons.person_outline, 312), // Person
        ],
      ),
    );
  }

  Widget _buildFooterIcon(IconData icon, double leftPosition, [bool isSelected = false]) {
    // The provided design uses fixed left positions, but for a responsive row,
    // MainAxisAlignment.spaceAround or .spaceBetween is better.
    // The sizes are also somewhat consistent, so we can use dynamic sizing based on screenWidth.
    return Icon(
      icon,
      size: screenWidth * 0.06, // Roughly 20-22px / 375px
      color: isSelected ? AppColors.background : AppColors.hintText, // Example for selected state
    );
  }
}