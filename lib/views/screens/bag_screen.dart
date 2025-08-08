import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_app/providers/cart_provider.dart';
import 'package:nike_app/utils/app_colors.dart';
import 'package:nike_app/views/address_payment_screens/adress_page.dart';
import 'package:nike_app/views/widgets/custom_footer.dart';
import 'package:provider/provider.dart';

class BagPage extends StatelessWidget {
  const BagPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final items = cartProvider.items;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.02,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Text(
                    'Bag',
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.065,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF130329),
                    ),
                  ),
                ],
              ),
            ),
            items.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        "Your bag is empty!",
                        style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey[600]),
                      ),
                    ),
                  )
                : Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                final cartItem = items[index];
                                final product = cartItem.product;

                                return Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          product.thumbnail,
                                          width: screenWidth * 0.28,
                                          height: screenWidth * 0.28,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: screenWidth * 0.04),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        product.title,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: GoogleFonts.poppins(
                                                          fontSize: screenWidth * 0.042,
                                                          fontWeight: FontWeight.w600,
                                                          color: AppColors.btncolor,
                                                        ),
                                                      ),
                                                      Text(
                                                        product.category,
                                                        style: GoogleFonts.poppins(
                                                          fontSize: screenWidth * 0.035,
                                                          color: Colors.grey[600],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    cartProvider.removeFromCart(product);
                                                  },
                                                  child: const Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.black,
                                                    size: 22,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: screenHeight * 0.005),
                                            Text(
                                              "White/Black/University Red\n6 (EU 40)",
                                              style: GoogleFonts.poppins(fontSize: screenWidth * 0.032),
                                            ),
                                            SizedBox(height: screenHeight * 0.01),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Qty ",
                                                      style: GoogleFonts.poppins(
                                                        fontSize: screenWidth * 0.034,
                                                        color: AppColors.btncolor,
                                                      ),
                                                    ),
                                                    DropdownButton<int>(
                                                      value: cartItem.quantity,
                                                      icon: Transform.rotate(
                                                        angle: -90 * 3.14 / 180,
                                                        child: const Icon(Icons.arrow_back_ios_new, size: 12),
                                                      ),
                                                      underline: Container(),
                                                      style: GoogleFonts.poppins(
                                                        fontSize: screenWidth * 0.034,
                                                        color: AppColors.btncolor,
                                                      ),
                                                      items: List.generate(10, (i) => i + 1)
                                                          .map((qty) => DropdownMenuItem(
                                                                value: qty,
                                                                child: Text(qty.toString()),
                                                              ))
                                                          .toList(),
                                                      onChanged: (newQty) {
                                                        if (newQty != null) {
                                                          cartProvider.updateQuantity(index, newQty);
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  "MRP : ₹ ${(product.price * cartItem.quantity).toStringAsFixed(2)}",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: screenWidth * 0.037,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.btncolor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                            child: Text(
                              "Incl. of all taxes\n(Also Includes all applicable duties)",
                              style: GoogleFonts.poppins(
                                fontSize: screenWidth * 0.032,
                                color: Colors.grey[600],
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Divider(height: 32, color: Colors.black12),
                          _buildTotalRow("Subtotal", cartProvider.subtotal, screenWidth),
                          _buildTotalRow("Delivery", cartProvider.delivery, screenWidth),
                          _buildTotalRow("Total", cartProvider.total, screenWidth, isTotal: true),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: screenHeight * 0.065,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AddressPage()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF130329),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                "Checkout",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: screenWidth * 0.042,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
            CustomFooter(screenWidth: screenWidth, currentIndex: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRow(String label, double amount, double screenWidth, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: isTotal ? screenWidth * 0.045 : screenWidth * 0.038,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? AppColors.btncolor : Colors.grey[800],
            ),
          ),
          Text(
            "₹ ${amount.toStringAsFixed(2)}",
            style: GoogleFonts.poppins(
              fontSize: isTotal ? screenWidth * 0.045 : screenWidth * 0.038,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? AppColors.btncolor : Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
