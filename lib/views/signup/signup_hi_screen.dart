import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_app/views/splash/splash1.dart';


class SignupSuccessScreen1 extends StatefulWidget {
  const SignupSuccessScreen1({super.key});

  @override
  State<SignupSuccessScreen1> createState() => _SignupSuccessScreen1State();
}

class _SignupSuccessScreen1State extends State<SignupSuccessScreen1> {
  @override
  void initState() {
    super.initState();

  
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.of(context).push(_createRouteToHiNikeSplash1());
    });
  }


  Route _createRouteToHiNikeSplash1() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => const HiNikeSplash1(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
      
        const begin = Offset(0.0, 0.1);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final fade = Tween<double>(begin: 0.0, end: 1.0);

        return FadeTransition(
          opacity: animation.drive(fade),
          child: SlideTransition(
            position: animation.drive(tween),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF130329),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 177),
              Image.asset(
                'lib/assets/nike_logo_white.png',
                width: 70,
                height: 24,
              ),
              const SizedBox(height: 40),
              Text(
                'Hi Jhon Smith,\nWelcome to Nike.',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Thanks for becoming a\nMember!',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  color: const Color(0xFF7C7C7C),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Member Since 2025',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
