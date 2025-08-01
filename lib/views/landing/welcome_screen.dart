import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_app/views/login/login_intro_screen.dart';
import 'package:nike_app/views/signup/signup_email_screen.dart';

class NikeWelcomeScreen extends StatelessWidget {
  const NikeWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          
          SizedBox.expand(
            child: Image.asset(
              'lib/assets/nike_bg.jpg',
              fit: BoxFit.cover,
            ),
          ),

          
          Positioned(
            top: 508,
            left: 20,
            child: Image.asset(
              'lib/assets/jordan.png',
              width: 50,
              height: 17,
              fit: BoxFit.contain,
            ),
          ),

         
          Positioned(
            top: 555,
            left: 20,
            child: SizedBox(
              width: 335,
              height: 90,
              child: Text(
                'Bringing Nike Members the best products, inspiration and stories in sport.',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),

        
          Positioned(
            top: 675,
            left: 20,
            child: Row(
              children: [
                
                SizedBox(
                  width: 106,
                  height: 42,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                 onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const SignupPhoneScreen(),
    ),
  );
},
                    child: Text(
                      'Sign up',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8), 

               
                SizedBox(
                  width: 106,
                  height: 42,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                     Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const HiNikeSignIn(),
    ),
  );
                    },
                    child: Text(
                      'Sign in',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
