import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_app/model/product.dart';
import 'package:nike_app/services/api_service.dart';

class ProductGridSection extends StatefulWidget {
  const ProductGridSection({super.key});

  @override
  State<ProductGridSection> createState() => _ProductGridSectionState();
}

class _ProductGridSectionState extends State<ProductGridSection> {
  late Future<List<Product>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = ApiService.fetchShoes();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 20.0, right: 20.0), 
      child: Container(
        
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: FutureBuilder<List<Product>>(
          future: _futureProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No products found.'));
            }

            final products = snapshot.data!.take(4).toList();

            return GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              padding: const EdgeInsets.all(8),
              childAspectRatio: 150 / 200,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true, 
              children: products.map((product) {
                return buildProductCard(
                  imageUrl: product.thumbnail,
                  title: product.title,
                  price: "₹ ${product.price}",
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  Widget buildProductCard({
    required String imageUrl,
    required String title,
    required String price,
  }) {
    return Container(
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[100],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.network(
                  imageUrl,
                  width: 150, 
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.black54,
                  size: 20,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "MRP: $price",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}