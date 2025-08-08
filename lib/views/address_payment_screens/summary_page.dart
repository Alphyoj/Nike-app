import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_app/model/cart_item.dart';
import 'package:nike_app/providers/cart_provider.dart';
import 'package:nike_app/utils/app_colors.dart';
import 'package:nike_app/views/address_payment_screens/payment_page.dart';
import 'package:provider/provider.dart';

class OrderSummaryPage extends StatelessWidget {
  final String name;
  final String addressType;
  final String fullAddress;

  const OrderSummaryPage({
    super.key,
    required this.name,
    required this.addressType,
    required this.fullAddress,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Order Summary", style: GoogleFonts.poppins(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stepper
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _stepIcon(Icons.person_pin, "Address", false),
                _stepIcon(Icons.receipt_long, "Order Summary", true),
                _stepIcon(Icons.payment, "Payment", false),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),

            // Address Summary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Delivery to:", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16)),
                const Icon(Icons.edit, size: 18),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(name, style: GoogleFonts.poppins(fontSize: 16)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.home, size: 16, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(addressType,
                          style: GoogleFonts.poppins(fontSize: 14, color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              fullAddress,
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade600),
            ),

            const SizedBox(height: 20),

            // Product Card
            ...cartProvider.items.map((item) => _buildProductCard(item, screenWidth)).toList(),

            // Qty
            const SizedBox(height: 12),
            Text("Qty", style: GoogleFonts.poppins(fontSize: 14, decoration: TextDecoration.underline)),
            const SizedBox(height: 12),

            // Price Details
            Text("Price Details", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            _buildPriceRow("Subtotal", cartProvider.subtotal),
            _buildPriceRow("Delivery", cartProvider.delivery),
            _buildPriceRow("Total", cartProvider.total, isBold: true),

            const Spacer(),

            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                     builder: (context) => PaymentPage(
  subtotal: cartProvider.subtotal,
  delivery: cartProvider.delivery,
  totalAmount: cartProvider.total,
),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF130329),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text("Continue", style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _stepIcon(IconData icon, String label, bool active) {
    return Column(
      children: [
        Icon(icon, color: active ? const Color(0xFF130329) : Colors.grey),
        const SizedBox(height: 4),
        Text(label,
            style: GoogleFonts.poppins(
              color: active ? const Color(0xFF130329) : Colors.grey,
              fontWeight: active ? FontWeight.w600 : FontWeight.normal,
            )),
        if (active)
          Container(
            height: 2,
            width: 40,
            color: const Color(0xFF130329),
            margin: const EdgeInsets.only(top: 4),
          ),
      ],
    );
  }

  Widget _buildProductCard(CartItem item, double screenWidth) {
    final product = item.product;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product.thumbnail,
                width: screenWidth * 0.2,
                height: screenWidth * 0.2,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title,
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black)),
                  Text("White/Black/University Red\n6 (EU 40)",
                      style: GoogleFonts.poppins(fontSize: 13)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isBold ? Colors.black : Colors.grey.shade700,
                fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
              )),
          Text("₹ ${amount.toStringAsFixed(2)}",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isBold ? Colors.black : Colors.grey.shade700,
                fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
              )),
        ],
      ),
    );
  }
}
