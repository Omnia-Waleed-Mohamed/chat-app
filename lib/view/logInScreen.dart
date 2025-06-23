
import 'package:chat_app/constants.dart';
import 'package:chat_app/view/chat_screen.dart';
import 'package:chat_app/view/signUpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  String? email;
  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Text(
                  "Login",
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Welcome back to the app",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 32),

                // Email TextField
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                  onChanged: (value) => email = value,
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: GoogleFonts.poppins(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                  ),
                ),
                const SizedBox(height: 16),

                // Password TextField
                TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  onChanged: (value) => password = value,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: GoogleFonts.poppins(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                  ),
                ),
                const SizedBox(height: 24),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() => isLoading = true);
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: email!,
                            password: password!,
                          );
Navigator.push(context,MaterialPageRoute(builder: 
                            (context)=>ChatScreen()));
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(
                          //       content: Text('Login successful')),
                          // );

                          // Navigate to home screen here if needed
                        } on FirebaseAuthException catch (e) {
                          String message;
                          switch (e.code) {
                            case 'user-not-found':
                              message = 'No user found for that email.';
                              break;
                            case 'wrong-password':
                              message = 'Incorrect password.';
                              break;
                            case 'invalid-email':
                              message = 'Invalid email address.';
                              break;
                            default:
                              message = 'Login failed. Please try again.';
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(message)),
                          );
                        } catch (_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Something went wrong. Please try again.')),
                          );
                        }
                        setState(() => isLoading = false);
                      }
                    },
                    child: Text(
                      "Login",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Sign Up Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account yet?",
                      style: GoogleFonts.poppins(),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.poppins(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

