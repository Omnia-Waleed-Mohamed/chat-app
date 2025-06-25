import 'package:chat_app/constants.dart';
import 'package:chat_app/view/chat_screen.dart';
import 'package:chat_app/view/logInScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //const SignUpScreen({super.key});
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading=false; 
bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        
        resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Text(
                  "Sign Up",
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Create a new account",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 32),

                //Username TextField
                TextField(
                  decoration: InputDecoration(
                    hintText: "Username",
                    hintStyle: GoogleFonts.poppins(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                        suffixIcon: Icon(Icons.person, color: Colors.grey)
                  ),
                ),
                const SizedBox(height: 16),

                // Email TextField
                TextFormField(
                  validator: (data) {
                    if (data!.isEmpty) {
                      return 'field is reqired';
                    }
                  },
                  onChanged: (data) {
                    email = data;
                  },
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: GoogleFonts.poppins(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                        suffixIcon: Icon(Icons.email_outlined, color: Colors.grey)
                  ),
                ),
                const SizedBox(height: 16),

                // Password TextField
                TextFormField(
  validator: (data) {
    if (data == null || data.isEmpty) {
      return 'Field is required';
    }
    return null; // ✅ لازم ترجعي null لو مفيش مشكلة
  },
  onChanged: (data) {
    password = data;
  },
  obscureText: !isPasswordVisible,
  decoration: InputDecoration(
    hintText: "Password",
    hintStyle: GoogleFonts.poppins(),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    contentPadding: const EdgeInsets.symmetric(
        horizontal: 16, vertical: 14),
    suffixIcon: IconButton(
      icon: Icon(
        isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        color: Colors.grey,
      ),
      onPressed: () {
        setState(() {
          isPasswordVisible = !isPasswordVisible;
        });
      },
    ),
  ),
),
                const SizedBox(height: 24),

                // Sign Up Button
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
                        
                        setState(() {
                          isLoading=true;
                        });
                        try {
                          var auth = FirebaseAuth.instance;
                          UserCredential user =
                              await auth.createUserWithEmailAndPassword(
                            email: email!,
                            password: password!,
                          );
                            Navigator.push(context,MaterialPageRoute(builder: 
                            (context)=>ChatScreen()));
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(
                          //       content: Text('Registration successful')),
                          // );
                        } on FirebaseAuthException catch (e) {
                          String errorMessage;
                          switch (e.code) {
                            case 'email-already-in-use':
                              errorMessage =
                                  'This email is already registered.';
                              break;
                            case 'invalid-email':
                              errorMessage = 'The email address is not valid.';
                              break;
                            case 'weak-password':
                              errorMessage = 'The password is too weak.';
                              break;
                            case 'operation-not-allowed':
                              errorMessage =
                                  'Email/password accounts are not enabled.';
                              break;
                            default:
                              errorMessage =
                                  'Registration failed. Please try again.';
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(errorMessage)),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'An error occurred. Please try again.')),
                          );
                        }
                        
                        setState(() {
                          isLoading=false;
                        });
                      }
                    },
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Already have an account?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: GoogleFonts.poppins(),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LogInScreen()));
                      },
                      child: Text(
                        "Login",
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
    ));
  }
}
