import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_app/model/product.dart';
import 'package:nike_app/services/api_service.dart';
import 'package:nike_app/utils/app_colors.dart';
import 'package:nike_app/views/screens/shoe_detail_screen.dart';
import 'package:nike_app/views/widgets/archive_card.dart';
import 'package:nike_app/views/widgets/best_seller_card.dart';
import 'package:nike_app/views/widgets/bran_card.dart';
import 'package:nike_app/views/widgets/colour_card.dart';
import 'package:nike_app/views/widgets/custom_footer.dart';
import 'package:nike_app/views/widgets/highlight_card.dart';
import 'package:nike_app/views/widgets/product_card.dart';
import 'package:nike_app/views/widgets/service_card.dart';
import 'package:nike_app/views/widgets/simplify_card.dart';
import 'package:nike_app/views/widgets/sport_category_card.dart';


class MwkScreen extends StatefulWidget {
  const MwkScreen({super.key});

  @override
  State<MwkScreen> createState() => _MwkScreenState();
}

class _MwkScreenState extends State<MwkScreen> {
  int selectedIndex = 0;
  bool isLoading = true;
  List<Product> allProducts = [];

  final List<String> categories = ['Men', 'Women', 'Kids'];

  @override
  void initState() {
    super.initState();
    loadShoes();
  }

  void loadShoes() async {
    try {
      final products = await ApiService.fetchShoes();
      setState(() {
        allProducts = products;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading shoes: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(screenWidth, screenHeight),
                    _buildShopHeading(),
                    _buildCategoryBar(),
                    _buildHighlightCards(itemCount: 6),
                    _buildPromotionalSection(),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 16.0),
                      child: Text(
                        'Shop By Icons',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          height: 1.0,
                        ),
                      ),
                    ),
                    _buildHighlightCards(itemCount: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 16.0),
                      child: Text(
                        'Simplify your style',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          height: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildTopPicksSection(screenWidth, 6),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 16.0),
                      child: Text(
                        'Shop by sport',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          height: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          _buildSportCategoryGrid(),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 16.0),
                      child: Text(
                        'Shop by colour',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          height: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildShopcolourGrid(),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 16.0),
                      child: Text(
                        'Our best Sellers',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          height: 1.0,
                        ),
                      ),
                    ),
                    // Here's where you add the ProductGridSection
                    const ProductGridSection(),

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
 Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 16.0),
                      child: Text(
                        'Shop by brand',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          height: 1.0,
                        ),
                      ),
                    ),
SizedBox(height: 15,),
_buildBrandCategoryGrid(),
                       Row(  crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Padding(
                              padding: const EdgeInsets.only(left: 20.0, top: 16.0),
                                                 child: Text(                   
                            'My intrest',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              height: 1.0,
                            ),
                                                 ),
                                               ),

                                                Padding(
                              padding: const EdgeInsets.only(left: 175.0, top: 16.0),
                              
                                                 child: Text(                   
                            'Add intrest',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.hintText,
                              height: 1.0,
                            ),
                                                 ),
                                               ),
                         ],
                       ),

                    SizedBox(height: 15,),
                    _buildSportintrestGrid(),

                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 16.0),
                      child: Text(
                        'Member services',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          height: 1.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    _buildServiceGrid()
                  ],

                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: CustomFooter(screenWidth: screenWidth),
            ),
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

  Widget _buildShopHeading() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Shop',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.background,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryBar() {
    return Container(
      width: double.infinity,
      height: 40,
      margin: const EdgeInsets.only(left: 20, top: 10),
      child: Row(
        children: List.generate(categories.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    categories[index],
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.background,
                    ),
                  ),
                  if (selectedIndex == index)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      width: 20,
                      height: 2,
                      color: AppColors.background,
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHighlightCards({int itemCount = 6}) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    List<Product> filtered = [];
    if (selectedIndex == 0) {
      filtered = allProducts.where((p) => p.category == 'mens-shoes').toList();
    } else if (selectedIndex == 1) {
      filtered = allProducts.where((p) => p.category == 'womens-shoes').toList();
    } else if (selectedIndex == 2) {
      filtered = allProducts.where((p) => p.category == 'tops').toList();
    }

    if (filtered.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Text(
            'No products found!',
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
          ),
        ),
      );
    }

    List<Product> displayList = [];
    while (displayList.length < itemCount) {
      displayList.addAll(filtered);
      if (filtered.isEmpty) break;
    }
    displayList = displayList.take(itemCount).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 16,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 109.33 / 150,
        children: List.generate(displayList.length, (index) {
          final product = displayList[index];
          return HighlightCard(
            title: product.title,
            imageUrl: product.thumbnail,
          );
        }),
      ),
    );
  }

  Widget _buildTopPicksSection(double screenWidth, int itemCount) {
    if (isLoading) {
      return const SizedBox(
        height: 170,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    List<Product> filtered = [];
    if (selectedIndex == 0) {
      filtered = allProducts.where((p) => p.category == 'mens-shoes').toList();
    } else if (selectedIndex == 1) {
      filtered = allProducts.where((p) => p.category == 'womens-shoes').toList();
    } else if (selectedIndex == 2) {
      filtered = allProducts.where((p) => p.category == 'tops').toList();
    }

    if (filtered.isEmpty) {
      return const SizedBox(
        height: 170,
        child: Center(child: Text('No top picks available')),
      );
    }

    final displayCount = filtered.length >= itemCount ? itemCount : filtered.length;

    return SizedBox(
      height: 170,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        itemCount: displayCount,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final product = filtered[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ShoeDetailPage(product: product),
                ),
              );
            },
            child: SimpleProductCard(
              imageUrl: product.thumbnail,
              productName: product.title,
            ),
          );
        },
      ),
    );
  }

  Widget _buildPromotionalSection() {
    final List<String> imagePaths = [
      'lib/assets/d1.jpg',
      'lib/assets/d2.jpg',
      'lib/assets/d3.jpg',
      'lib/assets/d4.jpg',
    ];

    final List<String> titles = [
      'New & Featured',
      'Shoes',
      'Clothing & Accessories',
      'Sales Update',
    ];

    return Container(
      width: 347,
      height: 387,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(4, (index) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  imagePaths[index],
                  width: 347,
                  height: 93,
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.3),
                  colorBlendMode: BlendMode.darken,
                ),
              ),
              Container(
                width: 338,
                height: 93,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color.fromRGBO(19, 3, 41, 0.8),
                      Color.fromRGBO(25, 13, 42, 0.5),
                      Color.fromRGBO(46, 46, 46, 0),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 15,
                child: Text(
                  titles[index],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildSportCategoryGrid() {
    final List<Map<String, String>> sportData = [
      {"imageAssetPath": "lib/assets/running.jpg", "categoryName": "Running"},
      {"imageAssetPath": "lib/assets/tennis.jpg", "categoryName": "Tennis"},
      {"imageAssetPath": "lib/assets/Training.jpg", "categoryName": "Training"},
      {"imageAssetPath": "lib/assets/basketball.jpg", "categoryName": "Basketball"},
      {"imageAssetPath": "lib/assets/yoga.jpg", "categoryName": "Yoga"},
      {"imageAssetPath": "lib/assets/dance.jpg", "categoryName": "Dance"},
      {"imageAssetPath": "lib/assets/football.jpg", "categoryName": "Football"},
      {"imageAssetPath": "lib/assets/running.jpg", "categoryName": "Skatboaarding"},
    ];

    List<Widget> rows = [];

    for (int i = 0; i < sportData.length; i += 3) {
      int end = (i + 3 < sportData.length) ? i + 3 : sportData.length;
      var sublist = sportData.sublist(i, end);

      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              for (int j = 0; j < 3; j++)
                if (j < sublist.length)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: SportCategoryCard(
                        imageAssetPath: sublist[j]['imageAssetPath']!,
                        categoryName: sublist[j]['categoryName']!,
                      ),
                    ),
                  )
                else
                  const Expanded(child: SizedBox()),
            ],
          ),
        ),
      );
    }

    return Column(children: rows);
  }
Widget _buildShopcolourGrid() {
  final List<Map<String, String>> sportData = [
    {"imageAssetPath": "lib/assets/brown.png", "categoryName": "Brown"},
    {"imageAssetPath": "lib/assets/grey.jpg", "categoryName": "Grey"},
    {"imageAssetPath": "lib/assets/black.jpg", "categoryName": "Black"},
    {"imageAssetPath": "lib/assets/white.jpg", "categoryName": "White"},
  ];

  return Container(
    width: 347.99,
    height: 305,
    margin: const EdgeInsets.only(top: 0, left: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: sportData.sublist(0, 2).map((item) {
            return ColourCard(
              imageAssetPath: item['imageAssetPath']!,
              categoryName: item['categoryName']!,
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: sportData.sublist(2, 4).map((item) {
            return ColourCard(
              imageAssetPath: item['imageAssetPath']!,
              categoryName: item['categoryName']!,
            );
          }).toList(),
        ),
      ],
    ),
  );
}
Widget _buildBrandCategoryGrid() {

return Container(
  width: 347.99,
  height: 305,
  margin: const EdgeInsets.only(top: 0, left: 20),
  padding: const EdgeInsets.all(8),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
  ),
  child: GridView.count(
    crossAxisCount: 3, 
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
    childAspectRatio: 150 / 200, 
    physics: const NeverScrollableScrollPhysics(), 
    children: [
      BranCard(imageAssetPath: "lib/assets/l5.png"),
      BranCard(imageAssetPath: "lib/assets/l1.jpg"),
      BranCard(imageAssetPath: "lib/assets/l3.jpg"),
      BranCard(imageAssetPath: "lib/assets/l6.png"),
      BranCard(imageAssetPath: "lib/assets/l4.png"),
      BranCard(imageAssetPath: "lib/assets/l2.png"),
    ],
  ),
);
}


Widget _buildSportintrestGrid() {
  final List<Map<String, String>> sportData = [
    {"imageAssetPath": "lib/assets/running.jpg", "categoryName": "Running"},
    {"imageAssetPath": "lib/assets/tennis.jpg", "categoryName": "Tennis"},
    {"imageAssetPath": "lib/assets/Training.jpg", "categoryName": "Training"},
    
  ];

  return Container(
    width: 347.99,
    height: 170, 
    margin: const EdgeInsets.only(top: 0, left: 20),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: sportData.map((data) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: SportCategoryCard(
              imageAssetPath: data['imageAssetPath']!,
              categoryName: data['categoryName']!,
            ),
          ),
        );
      }).toList(),
    ),
  );
}

Widget _buildServiceGrid() {
  final List<Map<String, String>> serviceData = [
    {
      'imageAsset': 'lib/assets/q1.jpg',
      'title': 'The ultimate shopping',
    },
    {
      'imageAsset': 'lib/assets/q5.jpg',
      'title': 'Check your order status',
    },
    {
      'imageAsset': 'lib/assets/q3.jpg',
      'title': 'Contact us',
    },
    {
      'imageAsset': 'lib/assets/q2.jpg',
      'title': 'Explore the member shop',
    },
    {
      'imageAsset': 'lib/assets/q4.jpg',
      'title': 'Customize with Nike by you',
    },
  ];

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: serviceData.sublist(0, 3).map((data) {
            return SizedBox(
              width: 109.33,
              height: 150,
              child: ServiceCard(
                imageAsset: data['imageAsset']!,
                title: data['title']!,
                subtitle: '',
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        Row(
          children: serviceData.sublist(3).map((data) {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SizedBox(
                width: 109.33,
                height: 150,
                child: ServiceCard(
                  imageAsset: data['imageAsset']!,
                  title: data['title']!,
                  subtitle: '',
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}


}