import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_app/utils/app_colors.dart';
import 'package:nike_app/utils/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nike_app/views/signup/signup_detail_screen.dart';

class SignupPhoneScreen extends StatefulWidget {
  const SignupPhoneScreen({super.key});

  @override
  State<SignupPhoneScreen> createState() => _SignupPhoneScreenState();
}

class _SignupPhoneScreenState extends State<SignupPhoneScreen> {
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String selectedCountryName = 'India';
  String selectedCountryCode = '+91';
  String verificationId = '';

  final List<Map<String, String>> countries = [
    {'name': 'India', 'code': '+91'},
    {'name': 'United States', 'code': '+1'},
    {'name': 'United Kingdom', 'code': '+44'},
    {'name': 'Germany', 'code': '+49'},
    {'name': 'Australia', 'code': '+61'},
    {'name': 'Canada', 'code': '+1'},
  ];

  void _selectCountry() async {
    final country = await showModalBottomSheet<Map<String, String>>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: countries.map((country) {
          return ListTile(
            title: Text('${country['name']} (${country['code']})'),
            onTap: () => Navigator.pop(context, country),
          );
        }).toList(),
      ),
    );

    if (country != null) {
      setState(() {
        selectedCountryName = country['name']!;
        selectedCountryCode = country['code']!;
      });
    }
  }

  Future<bool> _isPhoneAlreadyUsed(String fullPhoneNumber) async {
    try {
      final methods = await _auth.fetchSignInMethodsForEmail('$fullPhoneNumber@fake.com');
      return methods.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<void> _sendOTP() async {
    if (_formKey.currentState!.validate()) {
      final phone = phoneController.text.trim();
      final fullPhone = selectedCountryCode + phone;

      final isUsed = await _isPhoneAlreadyUsed(fullPhone);
      if (isUsed) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Phone number is already registered.')),
        );
        return;
      }

      await _auth.verifyPhoneNumber(
        phoneNumber: fullPhone,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Verification failed: ${e.message}')),
          );
        },
        codeSent: (String verId, int? resendToken) {
          setState(() {
            verificationId = verId;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignupDetailScreen(
                phoneNumber: fullPhone,
                verificationId: verificationId,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verId) {
          setState(() {
            verificationId = verId;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 79),
                  Row(
                    children: [
                      const Image(
                        image: AssetImage('lib/assets/nike_black.png'),
                        width: 41,
                        height: 14,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 13),
                      const Image(
                        image: AssetImage('lib/assets/jordan.png'),
                        width: 37,
                        height: 34,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'Enter your phone number to join us or sign in.',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 35),
                  GestureDetector(
                    onTap: _selectCountry,
                    child: Row(
                      children: [
                        Text(
                          '$selectedCountryName ($selectedCountryCode)',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_drop_down, color: Colors.black54),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: phoneController,
                    validator: AppValidators.validatePhone,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(color: AppColors.hintText),
                    decoration: InputDecoration(
                      hintText: 'Phone Number*',
                      hintStyle: GoogleFonts.poppins(
                        color: AppColors.hintText,
                        fontSize: 14,
                      ),
                      prefixText: '$selectedCountryCode ',
                      prefixStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.hintText),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.hintText),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppColors.hintText,
                      ),
                      children: [
                        const TextSpan(text: 'By continuing, I agree to Nike’s '),
                        TextSpan(
                          text: 'Privacy Policy.',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const TextSpan(text: '\nand '),
                        TextSpan(
                          text: 'Terms of Use.',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 106,
                      height: 36,
                      child: ElevatedButton(
                        onPressed: _sendOTP,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.background,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(
                          'Continue',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      const Expanded(child: Divider(color: Colors.grey)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('or', style: GoogleFonts.poppins()),
                      ),
                      const Expanded(child: Divider(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _socialButton('lib/assets/google.png'),
                      _socialButton('lib/assets/facebook.png'),
                      _socialButton('lib/assets/apple.png'),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _socialButton(String assetPath) {
    return SizedBox(
      width: 100,
      height: 36,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Image.asset(
            assetPath,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
