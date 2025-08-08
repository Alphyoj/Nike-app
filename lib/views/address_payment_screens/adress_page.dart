import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_app/utils/app_colors.dart';
import 'package:nike_app/views/address_payment_screens/summary_page.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final _formKey = GlobalKey<FormState>();

  bool _showAlternate = false;
  String _addressType = 'Home';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _altPhoneController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _houseController = TextEditingController();
  final TextEditingController _roadController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OrderSummaryPage(
            name: _nameController.text,
            addressType: _addressType,
            fullAddress:
                "${_houseController.text}, ${_roadController.text}, ${_landmarkController.text}, ${_cityController.text} - ${_pincodeController.text}, ${_stateController.text}",
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final fieldStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.grey),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Address"),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Step indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _stepIndicator(Icons.person_pin, "Address", true),
                  _stepIndicator(Icons.receipt_long, "Order Summary", false),
                  _stepIndicator(Icons.payment, "Payment", false),
                ],
              ),
              const SizedBox(height: 20),

              _buildTextField(_nameController, "Full Name (Required)*"),
              _buildTextField(
                _phoneController,
                "Phone number (Required)*",
                keyboardType: TextInputType.phone,
                validator: _validatePhone,
              ),

              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => setState(() => _showAlternate = !_showAlternate),
                child: Text(
                  _showAlternate ? "- Remove Alternate Phone Number" : "+ Add Alternate Phone Number",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              if (_showAlternate)
                _buildTextField(
                  _altPhoneController,
                  "Alternate Phone Number",
                  keyboardType: TextInputType.phone,
                  validator: _validatePhoneOptional,
                ),

              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildHalfField(_pincodeController, "Pincode (Required)*"),
                  _buildHalfField(_stateController, "State (Required)*"),
                  _buildHalfField(_cityController, "City (Required)*"),
                  _buildHalfField(_landmarkController, "Landmark (Required)*"),
                ],
              ),

              const SizedBox(height: 16),
              _buildTextField(_houseController, "House No., Building Name (Required)*"),
              _buildTextField(_roadController, "Road name, Area, Colony (Required)*"),

              const SizedBox(height: 16),
              Text("Type of address", style: GoogleFonts.poppins(fontSize: 16)),
              const SizedBox(height: 8),
              Row(
                children: [
                  _addressTypeButton("Home", Icons.home),
                  const SizedBox(width: 12),
                  _addressTypeButton("Work", Icons.business),
                ],
              ),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text("Save", style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator ?? _validateRequired,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _buildHalfField(TextEditingController controller, String label) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width / 2) - 26,
      child: _buildTextField(controller, label),
    );
  }

  Widget _stepIndicator(IconData icon, String label, bool active) {
    return Column(
      children: [
        Icon(icon, color: active ? Colors.black : Colors.grey),
        Text(label, style: GoogleFonts.poppins(color: active ? Colors.black : Colors.grey)),
        if (active)
          Container(
            margin: const EdgeInsets.only(top: 4),
            height: 2,
            width: 50,
            color: Colors.black,
          ),
      ],
    );
  }

  Widget _addressTypeButton(String type, IconData icon) {
    final bool isSelected = _addressType == type;

    return Expanded(
      child: OutlinedButton.icon(
        onPressed: () => setState(() => _addressType = type),
        icon: Icon(icon, color: isSelected ? Colors.black : Colors.grey),
        label: Text(type, style: GoogleFonts.poppins(color: isSelected ? Colors.black : Colors.grey)),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: isSelected ? Colors.black : Colors.grey.shade300),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: isSelected ? Colors.grey.shade100 : Colors.white,
        ),
      ),
    );
  }

  String? _validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone number is required';
    if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) return 'Enter valid 10-digit number';
    return null;
  }

  String? _validatePhoneOptional(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) return 'Enter valid 10-digit number';
    return null;
  }
}
