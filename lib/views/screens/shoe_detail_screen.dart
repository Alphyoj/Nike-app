
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_app/model/product.dart';
import 'package:nike_app/services/api_service.dart';
import 'package:nike_app/utils/app_colors.dart';
import 'package:nike_app/views/widgets/product_card.dart';

class ShoeDetailPage extends StatefulWidget {
  final Product product;

  const ShoeDetailPage({super.key, required this.product});

  @override
  State<ShoeDetailPage> createState() => _ShoeDetailPageState();
}

class _ShoeDetailPageState extends State<ShoeDetailPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  List<int> sizes = [6, 7, 8, 9, 10, 11];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            top: 90,
            bottom: 80, // leave space for footer
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // --- IMAGE CAROUSEL ---
                  Container(
                    width: 335,
                    height: 301,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          itemCount: product.images.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Image.network(
                              product.images[index],
                              fit: BoxFit.contain,
                              width: 335,
                              height: 301,
                            );
                          },
                        ),
                        Positioned(
                          bottom: 12,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                List.generate(product.images.length, (index) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: _currentPage == index
                                      ? const Color(0xFF130329)
                                      : const Color(0x80130329),
                                  shape: BoxShape.circle,
                                ),
                              );
                            }),
                          ),
                        ),
                        Positioned(
                          top: 28,
                          left: 286,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            
                            child: const Icon(
                              Icons.shopping_cart_outlined,
                              size: 22,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 82,
                          left: 286,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.share_outlined,
                              size: 22,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),
                  // --- TITLE, CATEGORY, PRICE ---
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      product.title,
                      style: GoogleFonts.poppins(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      product.category,
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.grey[700]),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "MRP : ₹ ${product.price}",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Inclusive of all taxes\n(also includes all applicable duties)",
                      style: GoogleFonts.poppins(
                          fontSize: 13, color: Colors.grey[600]),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // --- SIZES ---
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Size - UK",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 12,
                    children: sizes.map((size) {
                      return Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 22,
                          child: Text(
                            size.toString(),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // --- DESCRIPTION ---
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      product.description,
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // --- VIEW DETAILS with UNDERLINE ---
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "View product details",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 1,
                          width: 170,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // --- PRODUCT INFORMATION CARD ---
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 335,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Product Information",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF130329),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios,
                              color: Color(0xFF130329), size: 18),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- REVIEW CARD ---
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 335,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Review",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF130329),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Row(
                                children: List.generate(5, (index) {
                                  return const Icon(Icons.star,
                                      size: 16, color: Color(0xFF130329));
                                }),
                              ),
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios,
                              color: Color(0xFF130329), size: 18),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // --- RECOMMENDED ---
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "You might also like",
                      style: GoogleFonts.poppins(
                          fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTopPicksSection(screenWidth),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

         // --- FIXED FOOTER ---
Positioned(
  bottom: 0,
  left: 0,
  right: 0,
  child: Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 64,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: AppColors.btncolor,
                shape: RoundedRectangleBorder(
                  
                ),
              ),
              child: Text(
                "Add to Bag",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8), 
        Expanded(
          child: SizedBox(
            height: 64,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey[200],
                shape: RoundedRectangleBorder(
                 
                ),
              ),
              child: Text(
                "Buy Now",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
),


          // --- HEADER BAR ---
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 90,
              color: Colors.white,
              child: Stack(
                children: [
                  Positioned(
                    top: 48,
                    left: 16,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                  Positioned(
                    top: 53,
                    left: 48,
                    child: Text(
                      product.title,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopPicksSection(double screenWidth) {
    return FutureBuilder<List<Product>>(
      future: ApiService.fetchShoes(),
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
}
