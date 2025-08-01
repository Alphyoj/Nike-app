import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_app/model/product.dart';

class ShoeDetailPage extends StatelessWidget {
  final Product product;

  const ShoeDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    List<int> sizes = [6, 7, 8, 9, 10, 11];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: Text(
          product.title,
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
             
              SizedBox(
                height: 250,
                child: PageView.builder(
                  itemCount: product.images.length,
                  itemBuilder: (context, index) {
                    return Image.network(product.images[index], fit: BoxFit.contain);
                  },
                ),
              ),
              const SizedBox(height: 12),
             
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  product.title,
                  style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 4),
             
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  product.category,
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                ),
              ),
              const SizedBox(height: 8),
              
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "MRP : ₹ ${product.price}",
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                "Inclusive of all taxes\n(also includes all applicable duties)",
                style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              // Sizes
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Size - UK",
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 12,
                children: sizes.map((size) {
                  return CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 22,
                    child: Text(
                      size.toString(),
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    foregroundColor: Colors.black,
                    backgroundImage: const AssetImage(''),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  product.description,
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(backgroundColor: Colors.deepPurple),
              child: Text("Add to Bag", style: GoogleFonts.poppins(color: Colors.white)),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(backgroundColor: Colors.grey[200]),
              child: Text("Buy Now", style: GoogleFonts.poppins(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }
}
