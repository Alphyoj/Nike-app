import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_app/model/product.dart';
import 'package:nike_app/utils/app_colors.dart';
import 'package:nike_app/views/widgets/custom_footer.dart';
import 'package:nike_app/views/widgets/product_card.dart';
import 'package:nike_app/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.03),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.06),
                  child: Text(
                    'Good Morning John Smith',
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.064,
                      fontWeight: FontWeight.w600,
                      color: AppColors.background,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Top Picks for You',
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.053,
                              fontWeight: FontWeight.w500,
                              color: AppColors.background,
                            ),
                          ),
                          Text(
                            'Recommended products',
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.042,
                              fontWeight: FontWeight.w400,
                              color: AppColors.hintText,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'View All',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.042,
                          fontWeight: FontWeight.w400,
                          color: AppColors.hintText,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                _buildTopPicksSection(screenWidth),
                SizedBox(height: screenHeight * 0.04),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'New From Nike',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.053,
                          fontWeight: FontWeight.w500,
                          color: AppColors.background,
                        ),
                      ),
                      Text(
                        'View All',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.042,
                          fontWeight: FontWeight.w400,
                          color: AppColors.hintText,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                SizedBox(height: screenHeight * 0.12),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomFooter(screenWidth: screenWidth),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth,
      height: screenHeight * 0.11,
      padding: EdgeInsets.only(
        top: screenHeight * 0.06,
        left: screenWidth * 0.064,
        right: screenWidth * 0.064,
      ),
      color: AppColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: screenWidth * 0.146,
            height: screenHeight * 0.029,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: screenWidth * 0.08,
                  height: screenHeight * 0.024,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Image.asset(
                      'lib/assets/nike_black.png',
                      width: screenWidth * 0.053,
                      height: screenHeight * 0.0085,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.015),
                Image.asset(
                  'lib/assets/jordan.png',
                  width: screenWidth * 0.044,
                  height: screenHeight * 0.018,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          Icon(
            Icons.search,
            size: screenWidth * 0.06,
            color: AppColors.black,
          ),
        ],
      ),
    );
  }

   Widget _buildTopPicksSection(double screenWidth) {
    return FutureBuilder<List<Product>>(
      future: ApiService.fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 260,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return SizedBox(
            height: 260,
            child: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox(
            height: 260,
            child: Center(child: Text('No products available')),
          );
        }

        final products = snapshot.data!;

        return SizedBox(
          height: 260,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            itemCount: products.length >= 6 ? 6 : products.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                imageUrl: product.thumbnail, 
                productName: product.title,
                category: product.category,
                price: product.price,
              );
            },
          ),
        );
      },
    );
  }
}
