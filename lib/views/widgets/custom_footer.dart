import 'package:flutter/material.dart';
import 'package:nike_app/utils/app_colors.dart';

import 'package:nike_app/views/screens/home_screen.dart';
import 'package:nike_app/views/screens/mwk_screen.dart'; 

class CustomFooter extends StatelessWidget {
  final double screenWidth;

  const CustomFooter({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildFooterIcon(context, Icons.home_outlined, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }, true), 

          _buildFooterIcon(context, Icons.shopping_bag_outlined, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MwkScreen()),
            );
          }), 

          _buildFooterIcon(context, Icons.favorite_border, () {
            
          }),

          _buildFooterIcon(context, Icons.shopping_cart_outlined, () {
            
          }),

          _buildFooterIcon(context, Icons.person_outline, () {
          
          }),
        ],
      ),
    );
  }

  Widget _buildFooterIcon(BuildContext context, IconData icon, VoidCallback onTap, [bool isSelected = false]) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        size: screenWidth * 0.06,
        color: isSelected ? AppColors.background : AppColors.hintText,
      ),
    );
  }
}
