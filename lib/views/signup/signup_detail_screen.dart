import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_app/utils/app_colors.dart';
import 'package:nike_app/utils/validators.dart';
import 'package:nike_app/views/signup/SignupSuccessScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupDetailScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  const SignupDetailScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });

  @override
  State<SignupDetailScreen> createState() => _SignupDetailScreenState();
}

class _SignupDetailScreenState extends State<SignupDetailScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController codeController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  bool _obscurePassword = true;
  bool emailUpdates = false;
  bool agreePolicy = false;
  bool showPasswordGuidelines = false;

  @override
  void dispose() {
    codeController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    if (!agreePolicy) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You must agree to Privacy Policy and Terms.")),
      );
      return;
    }

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: codeController.text.trim(),
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SignupSuccessScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP verification failed: ${e.toString()}")),
      );
    }
  }

  void _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18),
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year - 13),
    );

    if (picked != null) {
      setState(() {
        dayController.text = picked.day.toString().padLeft(2, '0');
        monthController.text = picked.month.toString().padLeft(2, '0');
        yearController.text = picked.year.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset('lib/assets/nike_black.png', width: 41, height: 14),
                    const SizedBox(width: 16),
                    Image.asset('lib/assets/jordan.png', width: 37, height: 34),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  "Now let’s make you a Nike Member.",
                  style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 24),
                Text(
                  "We’ve sent a code to ${widget.phoneNumber}",
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
                _buildInputField(
                  label: "OTP Code*",
                  controller: codeController,
                  validator: AppValidators.validateOtp,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Resend code in 9s",
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildInputField(
                        label: "First Name*",
                        controller: firstNameController,
                        validator: AppValidators.validateName,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildInputField(
                        label: "Surname*",
                        controller: lastNameController,
                        validator: AppValidators.validateName,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  label: "Password*",
                  controller: passwordController,
                  validator: (value) {
                    final error = AppValidators.validatePassword(value);
                    setState(() => showPasswordGuidelines = error != null);
                    return error;
                  },
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                if (showPasswordGuidelines) ...[
                  const SizedBox(height: 8),
                  Text(
                    "\u2715 Minimum of 6 characters\n\u2715 Must contain uppercase and number",
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.red),
                  ),
                ],
                const SizedBox(height: 24),
                Text(
                  "Date of Birth",
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: _pickDate,
                  child: AbsorbPointer(
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildInputField(
                            label: "Day*",
                            controller: dayController,
                            validator: AppValidators.validateDOB,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildInputField(
                            label: "Month*",
                            controller: monthController,
                            validator: AppValidators.validateDOB,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildInputField(
                            label: "Year*",
                            controller: yearController,
                            validator: AppValidators.validateDOB,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Get a Nike Member Reward on your birthday.",
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 32),
                CheckboxListTile(
                  value: emailUpdates,
                  onChanged: (val) => setState(() => emailUpdates = val!),
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    "Sign up for emails to get updates\nfrom Nike on products, offers and your Member benefits",
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                ),
                CheckboxListTile(
                  value: agreePolicy,
                  onChanged: (val) => setState(() => agreePolicy = val!),
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Wrap(
                    children: [
                      Text("I agree to Nike’s ", style: GoogleFonts.poppins(fontSize: 14)),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Privacy Policy ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Text("and ", style: GoogleFonts.poppins(fontSize: 14)),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Terms of Use",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 171,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.backgroundDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Create Account",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(fontSize: 14),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: GoogleFonts.poppins(color: Colors.grey),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
