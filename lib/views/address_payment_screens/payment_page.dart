import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentProcessPage extends StatelessWidget {
  final String paymentMethod;
  const PaymentProcessPage({super.key, required this.paymentMethod});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Processing Payment via $paymentMethod"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text(
              "Redirecting to $paymentMethod...",
              style: GoogleFonts.poppins(fontSize: 18),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Simulate Payment Success"),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentPage extends StatefulWidget {
  final double subtotal;
  final double delivery;
  final double totalAmount;

  const PaymentPage({
    super.key,
    required this.subtotal,
    required this.delivery,
    required this.totalAmount,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedPaymentType = 'UPI';
  String? _selectedUpiApp;
  String? _selectedBank;
  bool _showAllBanks = false;

  @override
  void initState() {
    super.initState();
    _selectedUpiApp = 'Paypal';
    _selectedBank = 'HDFC Bank';
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Payment Successful! Your order has been placed.",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _simulatePaymentProcess(String paymentMethod) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Redirecting to $paymentMethod...", style: GoogleFonts.poppins()),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 1),
      ),
    );

    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PaymentProcessPage(paymentMethod: paymentMethod),
      ),
    );

    if (result == true) {
      _showSuccessMessage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Order Summary", style: GoogleFonts.poppins(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: const BackButton(color: Colors.black),
      ),
      // The main fix: We wrap the Column in a SingleChildScrollView
      // to prevent overflow when the keyboard is active.
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "Men's Road Racing Shoes\n6 (EU 40)",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),
              _buildPriceRow("Subtotal", widget.subtotal),
              _buildPriceRow("Delivery", widget.delivery),
              _buildPriceRow("Total", widget.totalAmount),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _paymentIcon('UPI', 'lib/assets/pa.png'),
                  _paymentIcon('Card', 'assets/images/card_icon.png'),
                  _paymentIcon('Bank', 'assets/images/bank_icon.png'),
                  _paymentIcon('Cash', 'assets/images/cash_icon.png'),
                ],
              ),
              const SizedBox(height: 24),

              // We remove the Expanded widget here as it's not needed
              // inside a SingleChildScrollView and can cause layout issues.
              _buildPaymentDetails(),
              
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedPaymentType == 'Cash') {
                      _showSuccessMessage();
                    } else if (_selectedPaymentType == 'UPI') {
                      if (_selectedUpiApp != null) {
                        _simulatePaymentProcess(_selectedUpiApp!);
                      }
                    } else if (_selectedPaymentType == 'Bank') {
                      if (_selectedBank != null) {
                        _simulatePaymentProcess(_selectedBank!);
                      }
                    } else if (_selectedPaymentType == 'Card') {
                      // This part needs to be handled separately (e.g., form validation)
                      // _simulatePaymentProcess("Card"); // You might want to call this here
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF130329),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    _selectedPaymentType == 'Card' ? "Please complete form" : "Place Order",
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 14)),
          Text("₹ ${amount.toStringAsFixed(2)}", style: GoogleFonts.poppins(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _paymentIcon(String type, String imagePath) {
    bool isSelected = _selectedPaymentType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentType = type;
        });
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF130329) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? Colors.transparent : Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Note: The 'pa.png' image path looks non-standard.
            // You may need to verify this path or replace it.
            if (type == 'UPI')
              Image.asset(imagePath, width: 32, height: 32, color: isSelected ? Colors.white : Colors.black)
            else if (type == 'Card')
              Icon(Icons.credit_card, color: isSelected ? Colors.white : Colors.black, size: 32)
            else if (type == 'Bank')
              Icon(Icons.account_balance, color: isSelected ? Colors.white : Colors.black, size: 32)
            else if (type == 'Cash')
              Icon(Icons.payments, color: isSelected ? Colors.white : Colors.black, size: 32),
            const SizedBox(height: 4),
            Text(
              type,
              style: GoogleFonts.poppins(color: isSelected ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetails() {
    switch (_selectedPaymentType) {
      case 'UPI':
        return _buildUpiOptions();
      case 'Card':
        return _buildCardForm();
      case 'Bank':
        return _buildNetBankingOptions();
      case 'Cash':
        return _buildCashOption();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildUpiOptions() {
    return Column(
      children: [
        _upiTile('Paypal', 'lib/assets/paypal.png'),
        _upiTile('Gpay', 'lib/assets/gpay.png'),
        _upiTile('Paytm', 'lib/assets/paytm.png'),
        _upiTile('PhonePe', 'lib/assets/phonepe.png'),
      ],
    );
  }

  Widget _upiTile(String name, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(imagePath, width: 40),
          const SizedBox(width: 16),
          Text(name, style: GoogleFonts.poppins(fontSize: 16)),
          const Spacer(),
          Radio(
            value: name,
            groupValue: _selectedUpiApp,
            onChanged: (String? value) {
              setState(() {
                _selectedUpiApp = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCardForm() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade300)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Card Number",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter your card number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey.shade100,
                filled: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                "Card number is required",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Valid Thru",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'MM/YY',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CVV",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'CVV',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _simulatePaymentProcess("Card");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF130329),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  "Done",
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNetBankingOptions() {
    final List<String> banks = [
      'HDFC Bank',
      'State Bank of India',
      'ICICI Bank',
      'Kotak Mahindra Bank',
      'Axis Bank',
      'HSBC Bank',
      'Standard Chartered Bank',
    ];

    final displayedBanks = _showAllBanks ? banks : banks.sublist(0, 4);

    return Column(
      children: [
        ...displayedBanks.map((bankName) => _bankTile(bankName)).toList(),
        if (!_showAllBanks)
          TextButton(
            onPressed: () {
              setState(() {
                _showAllBanks = true;
              });
            },
            child: Text(
              "Show more banks",
              style: GoogleFonts.poppins(color: const Color(0xFF130329)),
            ),
          ),
      ],
    );
  }

  Widget _bankTile(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.account_balance, size: 40),
          const SizedBox(width: 16),
          Text(name, style: GoogleFonts.poppins(fontSize: 16)),
          const Spacer(),
          Radio(
            value: name,
            groupValue: _selectedBank,
            onChanged: (String? value) {
              setState(() {
                _selectedBank = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCashOption() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade300)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            "You have selected Cash on Delivery.",
            style: GoogleFonts.poppins(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
