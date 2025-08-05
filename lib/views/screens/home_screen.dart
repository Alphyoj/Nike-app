import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_app/model/product.dart';
import 'package:nike_app/utils/app_colors.dart';
import 'package:nike_app/views/screens/shoe_detail_screen.dart';
import 'package:nike_app/views/widgets/archive_card.dart';
import 'package:nike_app/views/widgets/custom_footer.dart';
import 'package:nike_app/views/widgets/product_card.dart';
import 'package:nike_app/services/api_service.dart';
import 'package:nike_app/views/widgets/promo_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(screenWidth, screenHeight),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
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
                    SizedBox(
                      height: 384,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 24),
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: const [
                            OverlayProductCard(
                              imageAsset: 'lib/assets/promo1.png',
                              subtitle: 'Apply pressure',
                              title: 'LEBRON XXII',
                              buttonText: 'Explore',
                              buttonWidth: 109,
                            ),
                            OverlayProductCard(
                              imageAsset: 'lib/assets/promo2.jpg',
                              subtitle: 'Just in',
                              title: 'KIDS’LEBRON XXII‘TUNNEL VISION’',
                              buttonText: 'Explore',
                              buttonWidth: 109,
                            ),
                            OverlayProductCard(
                              imageAsset: 'lib/assets/promo3.jpg',
                              subtitle: 'IOC Refugee Olympic Team',
                              title: 'WATCH WHERE\nWE’RE GOING',
                              buttonText: 'Learn More',
                              buttonWidth: 109,
                            ),
                            OverlayProductCard(
                              imageAsset: 'lib/assets/promo4.jpg',
                              subtitle: '',
                              title: '',
                              buttonText: 'View all',
                              buttonWidth: 109,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: SizedBox(
                        height: 141,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildPromoImageCard('lib/assets/newlook2.jpg'),
                            const SizedBox(width: 12),
                            _buildPromoImageCard('lib/assets/newlook1.jpg'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
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
                    _buildTopPicksSection(screenWidth),
                    SizedBox(height: screenHeight * 0.04),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      child: Text(
                        'Stories for you',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.053,
                          fontWeight: FontWeight.w500,
                          color: AppColors.background,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: _buildStoriesForYouCard(
                        'lib/assets/story_image.jpg',
                        'Buying Guide',
                        'How to Choose the Best\nNike Soccer Cleats for Kids',
                        'View All',
                      ),
                    ),

                    
                    SizedBox(height: screenHeight * 0.04),
                                       Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          ArchiveCard(
                            imageAsset: 'lib/assets/promo4.jpg',
                            title: 'The origins of the Air Force 1',
                            subtitle: 'From the archives',
                          ),
                          ArchiveCard(
                            imageAsset: 'lib/assets/ar1.jpg',
                            title: 'The origins of the Dunk',
                            subtitle: 'From the archives',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: AppColors.black.withOpacity(0.4)),
                        ),
                        child: Center(
                          child: Text(
                            'View All',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.background,
                            ),
                          ),
                        ),
                      ),
                    ),



                    SizedBox(height: screenHeight * 0.04),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Because you like',
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.053,
                              fontWeight: FontWeight.w500,
                              color: AppColors.background,
                            ),
                          ),
                          Text(
                            'Basketball',
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
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Because you like',
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.053,
                              fontWeight: FontWeight.w500,
                              color: AppColors.background,
                            ),
                          ),
                          Text(
                            'Cross Training',
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
                  ],
                ),
              ),
            ),
            CustomFooter(screenWidth: screenWidth, currentIndex: 0),

          ],
        ),
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
  const double sectionHeight = 260;

  return FutureBuilder<List<Product>>(
    future: ApiService.fetchShoes(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const SizedBox(
          height: sectionHeight,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (snapshot.hasError) {
        return SizedBox(
          height: sectionHeight,
          child: Center(child: Text('Error: ${snapshot.error}')),
        );
      }

      final products = snapshot.data;
      if (products == null || products.isEmpty) {
        return const SizedBox(
          height: sectionHeight,
          child: Center(child: Text('No products available')),
        );
      }

      return SizedBox(
        height: sectionHeight,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          itemCount: products.length >= 6 ? 6 : products.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final product = products[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ShoeDetailPage(product: product),
                  ),
                );
              },
              child: ProductCard(
                imageUrl: product.thumbnail,
                productName: product.title,
                category: product.category,
                price: product.price,
                product: product,
              ),
            );
          },
        ),
      );
    },
  );
}



  Widget _buildPromoImageCard(String imageAsset) {
    return Container(
      width: 352,
      height: 141,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0x66000000),
            offset: const Offset(0, 2),
            blurRadius: 3,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.asset(
              imageAsset,
              width: 352,
              height: 141,
              fit: BoxFit.cover,
            ),
            Container(
              width: 352,
              height: 141,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromRGBO(19, 3, 41, 0.68),
                    Color.fromRGBO(19, 3, 41, 0.0),
                  ],
                  stops: [0.5217, 1.0],
                ),
              ),
            ),
            Positioned(
              top: 25,
              left: 13,
              child: SizedBox(
                width: 172,
                height: 18,
                child: Text(
                  'New Week New Looks',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    height: 1.0,
                    color: Colors.white.withOpacity(1),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 53,
              left: 13,
              child: SizedBox(
                width: 259,
                height: 42,
                child: Text(
                  'Give your wardrobe a boost with this week’s fresh arrivals.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.white.withOpacity(1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoriesForYouCard(
      String imageAsset, String subtitle, String title, String buttonText) {
    return Container(
      width: 347,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 2),
            blurRadius: 3,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(34),
        child: Stack(
          children: [
            Image.asset(
              imageAsset,
              width: 347,
              height: 300,
              fit: BoxFit.cover,
            ),
            Container(
              width: 347,
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0),
                    const Color.fromRGBO(19, 3, 41, 0.4),
                    const Color.fromRGBO(19, 3, 41, 0.9),
                  ],
                  stops: const [0.0, 0.2467, 0.5753],
                ),
              ),
            ),
            Positioned(
              bottom: 60,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 228,
              child: Container(
                width: 80,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.transparent, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x66000000),
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    buttonText,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                      color: AppColors.background,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  

  
}