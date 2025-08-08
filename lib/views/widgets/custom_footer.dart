import 'package:flutter/material.dart';
import 'package:nike_app/utils/app_colors.dart';
import 'package:nike_app/views/screens/bag_screen.dart';
import 'package:nike_app/views/screens/favorite_screen.dart';
import 'package:nike_app/views/screens/home_screen.dart';
import 'package:nike_app/views/screens/mwk_screen.dart';
import 'package:nike_app/views/screens/profile_screen.dart';

class CustomFooter extends StatelessWidget {
  final double screenWidth;
  final int currentIndex; 

  const CustomFooter({super.key, required this.screenWidth, required this.currentIndex});

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
          _buildFooterIcon(context, Icons.home_outlined, 0, () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
          }),
          _buildFooterIcon(context, Icons.shopping_bag_outlined, 1, () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MwkScreen()));
          }),
          _buildFooterIcon(context, Icons.favorite_border, 2, () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => FavoritesPage()));
          }),
          _buildFooterIcon(context, Icons.shopping_cart_outlined, 3, () {
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => BagPage()));
          }),
          _buildFooterIcon(context, Icons.person_outline, 4, () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
          }),
        ],
      ),
    );
  }

  Widget _buildFooterIcon(BuildContext context, IconData icon, int index, VoidCallback onTap) {
    final bool isSelected = index == currentIndex;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: screenWidth * 0.06,
            color: isSelected ? AppColors.background : AppColors.hintText,
          ),
          const SizedBox(height: 4),
          Container(
            width: 25,
            height: 3,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.background : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
