import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutixapp/auth/auth.dart';
import 'package:flutixapp/ui/pages/splash_screen/confirmation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  File? _image;

  final TextEditingController _ctrlNama = TextEditingController();
  final TextEditingController _ctrlEmail = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();
  final TextEditingController _ctrlConfirmPassword = TextEditingController();

 
  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  Future<String> _uploadImage() async {
    if (_image == null) return '';

    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;

      final Reference storageRef = FirebaseStorage.instance.ref().child(
          'profile_pictures/${user?.uid}/${DateTime.now().millisecondsSinceEpoch}.png');

      await storageRef.putFile(_image!);
      final String downloadURL = await storageRef.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  // Modify the handleSubmit method to include image uploading
  handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final nama = _ctrlNama.text;
      final email = _ctrlEmail.text;
      final password = _ctrlPassword.text;

      setState(() => _loading = true);

      try {
        // Upload gambar profil
        final imageUrl = await _uploadImage();

        // Mendaftarkan pengguna
        final userCredential =
            await Auth().regis(email, password, nama, imageUrl, 300000);

        // Mengambil dan menampilkan saldo
        final saldo = await Auth().getSaldo(userCredential.user!.uid);
        //print('Saldo Pengguna: $saldo');

        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const confir()),
        );
      } catch (error) {
        // Tangani kesalahan
        print('Error during registration: $error');
      } finally {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 0, 107, 152),
              size: 32,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
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
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      "Create Your",
                      style: GoogleFonts.raleway(
                          fontSize: 24,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      "Account",
                      style: GoogleFonts.raleway(
                          fontSize: 24,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Stack(
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: _getImage,
                          child: Container(
                            margin: const EdgeInsets.all(20),
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(90),
                              image: _image != null
                                  ? DecorationImage(
                                      image: FileImage(_image!),
                                      fit: BoxFit.cover,
                                    )
                                  : const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/card/profile.png"),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      _image == null
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 20, top: 125.0, right: 20),
                                child: Icon(
                                  Icons.add_circle,
                                  color: Color.fromARGB(255, 0, 107, 152),
                                  size: 40,
                                ),
                              ),
                            )
                          : const Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 20, top: 125.0, right: 20),
                                child: SizedBox(),
                              ),
                            ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                    child: TextFormField(
                      controller: _ctrlNama,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insert your full name';
                        }
                        return null;
                      },
                  style: GoogleFonts.raleway(color: Colors.white),

                      decoration: InputDecoration(
                        border: const OutlineInputBorder(borderSide: BorderSide()),
                        labelText: "Full Name",
                        labelStyle: GoogleFonts.raleway(color: const Color.fromARGB(255, 255, 255, 255)),
                        hintText: "Your Full Name...",
                        hintStyle: GoogleFonts.raleway(color: const Color.fromARGB(255, 255, 255, 255)),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 3,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 0, 107, 152),
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
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
                        border: const OutlineInputBorder(borderSide: BorderSide()),
                        labelText: "Email Address",
                        labelStyle: GoogleFonts.raleway(color: const Color.fromARGB(255, 255, 255, 255)),
                        hintText: "Your Email Address...",
                        hintStyle: GoogleFonts.raleway(color: const Color.fromARGB(255, 255, 255, 255)),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 3,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 0, 107, 152),
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: TextFormField(
                      controller: _ctrlPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insert your password';
                        }
                        return null;
                      },
                  style: GoogleFonts.raleway(color: Colors.white),

                      obscureText: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(borderSide: BorderSide()),
                        labelText: "Password",
                        labelStyle: GoogleFonts.raleway(color: const Color.fromARGB(255, 255, 255, 255)),
                        hintText: "***********",
                        hintStyle: GoogleFonts.raleway(color: const Color.fromARGB(255, 255, 255, 255)),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 3,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 0, 107, 152),
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: TextFormField(
                      controller: _ctrlConfirmPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insert your confirm password';
                        }
                        return null;
                      },
                      obscureText: true,
                  style: GoogleFonts.raleway(color: Colors.white),

                      decoration: InputDecoration(
                        border: const OutlineInputBorder(borderSide: BorderSide()),
                        labelText: "Confirm Password",
                        labelStyle: GoogleFonts.raleway(color: Colors.white),
                        hintText: "***********",
                        hintStyle: GoogleFonts.raleway(color: Colors.white),
                        
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 3,
                          ),
                        ),
                        
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 0, 107, 152),
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 40, left: 20, bottom: 40),
                        child: Text(
                          "Continue to Sign Up",
                          style: GoogleFonts.raleway(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => handleSubmit(),
                        child: _loading
                            ? const Padding(
                                padding: EdgeInsets.only(
                                    left: 70, top: 40, bottom: 40, right: 20),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFE1A20B),
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : const Padding(
                                padding: EdgeInsets.only(
                                    left: 70, top: 40, bottom: 40, right: 20),
                                child: Icon(
                                  Icons.arrow_circle_right,
                                  color: Color.fromARGB(255, 0, 107, 152),
                                  size: 60,
                                ),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}