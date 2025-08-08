import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nike_app/utils/app_colors.dart';
import 'package:nike_app/views/widgets/custom_footer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;
  String _userName = "John Smith";

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
      });
    }
  }

  void _showEditDialog() {
    final TextEditingController nameController = TextEditingController(text: _userName);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 24,
          right: 24,
          top: 20,
        ),
        child: Wrap(
          children: [
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : const AssetImage('assets/images/profile.jpg') as ImageProvider,
                      child: const Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 14,
                          child: Icon(Icons.edit, size: 16, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _userName = nameController.text;
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.btncolor,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: Text("Save", style: GoogleFonts.poppins(color: Colors.white)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 24),
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _showEditDialog,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: _profileImage != null
                              ? FileImage(_profileImage!)
                              : const AssetImage('assets/images/profile.jpg') as ImageProvider,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _userName,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton(
                        onPressed: _showEditDialog,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.btncolor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        ),
                        child: Text(
                          "Edit Profile",
                          style: GoogleFonts.poppins(
                            color: AppColors.btncolor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    _ProfileOption(icon: Icons.inventory_2_outlined, label: "Orders"),
                    VerticalDivider(width: 1, color: Colors.grey),
                    _ProfileOption(icon: Icons.grid_view_outlined, label: "Pass"),
                    VerticalDivider(width: 1, color: Colors.grey),
                    _ProfileOption(icon: Icons.event_note_outlined, label: "Events"),
                    VerticalDivider(width: 1, color: Colors.grey),
                    _ProfileOption(icon: Icons.settings_outlined, label: "Settings"),
                  ],
                ),
                const SizedBox(height: 30),
                ListTile(
                  title: Text("Inbox", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                  subtitle: const Text("View messages"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Text(
                          '2',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  title: Text("Your Nike Member Rewards", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                  subtitle: const Text("2 available"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Following (19)", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16)),
                    GestureDetector(
                      onTap: () {},
                      child: Text("Edit", style: GoogleFonts.poppins(color: Colors.grey)),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 95,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      _FollowingImage(imagePath: 'lib/assets/football.jpg'),
                      _FollowingImage(imagePath: 'lib/assets/basketball.jpg'),
                      _FollowingImage(imagePath: 'lib/assets/tennis.jpg'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomFooter(screenWidth: screenWidth, currentIndex: 4),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ProfileOption({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 28, color: Colors.black),
        const SizedBox(height: 6),
        Text(label, style: GoogleFonts.poppins(fontSize: 12)),
      ],
    );
  }
}

class _FollowingImage extends StatelessWidget {
  final String imagePath;

  const _FollowingImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 109,
      height: 95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
