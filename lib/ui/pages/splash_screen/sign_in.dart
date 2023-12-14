// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types

import 'package:flutixapp/auth/auth.dart';
import 'package:flutixapp/ui/widgets/bottomnav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'sign_up.dart';

class signIn extends StatefulWidget {
  const signIn({super.key});

  @override
  State<signIn> createState() => _signInState();
}

class _signInState extends State<signIn> {
  bool _loading = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ctrlEmail = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();

  handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final email = _ctrlEmail.text;
      final password = _ctrlPassword.text;

      setState(() => _loading = true);

      try {
        await Auth().login(email, password);
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => BottomNav()),
        );
      } catch (error) {
        print('Error during login: $error');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed. Please try again.'),
          ),
        );
      } finally {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 0, 107, 152),
            Color.fromARGB(255, 1, 3, 25),
            Color.fromARGB(255, 0, 107, 152),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40, left: 20),
                      child: Text(
                        "Welcome back,",
                        style: GoogleFonts.raleway(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Explorer!",
                    style: GoogleFonts.raleway(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _ctrlEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insert your email address';
                    }
                    return null;
                  },
                  style: GoogleFonts.raleway(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    labelText: "Email Address",
                    labelStyle: GoogleFonts.raleway(color: Colors.white),
                    hintText: "Insert your email address...",
                    hintStyle: GoogleFonts.raleway(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 3,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 107, 152),
                        width: 3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Form(
                child: TextFormField(
                  controller: _ctrlPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insert your password';
                    }
                    return null;
                  },
                  obscureText: true,
                  style: GoogleFonts.raleway(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    labelText: "Password",
                    labelStyle: GoogleFonts.raleway(color: Colors.white),
                    hintText: "*********",
                    hintStyle: GoogleFonts.raleway(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 3,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 107, 152),
                        width: 3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 85, left: 20),
                  child: Text(
                    "Continue to Sign In",
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => handleSubmit(),
                  child: _loading
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 100, top: 80, right: 20),
                          child: const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 0, 107, 152),
                              strokeWidth: 2,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                              left: 100, top: 80, right: 20),
                          child: Icon(
                            Icons.arrow_circle_right,
                            color: Color.fromARGB(255, 0, 107, 152),
                            size: 60,
                          ),
                        ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 80, top: 80),
                  child: Text(
                    "Start fresh now?",
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => signUp()));
                        // MaterialPageRoute(builder: (context) => uprof()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 80, right: 20),
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.raleway(
                        color: Color.fromARGB(255, 0, 107, 152),
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
