import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  String username = '';
  String email = '';
  String profilePictureUrl = '';
  String oldPass = '';
  String newPass = '';

  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerOldPass = TextEditingController();
  final TextEditingController _controllerNewPass = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('nama') ?? '';
      email = prefs.getString('email') ?? '';
      oldPass = prefs.getString('password') ?? '';
      newPass = prefs.getString(_controllerNewPass.text) ?? '';
      profilePictureUrl = prefs.getString('profilePictureUrl') ?? '';
    });
  }

  Future<String> _loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('profilePictureUrl') ?? '';
  }

  handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final nama = _controllerNama.value.text;
      final email = _controllerEmail.value.text;
      final password = _controllerNewPass.value.text;

      setState(() => _loading = true);

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference users = firestore.collection('users');
      User? user = FirebaseAuth.instance.currentUser;

      String id = FirebaseAuth.instance.currentUser!.uid;
      await users.doc(id).update({
        'fullName': _controllerNama.text.isEmpty
            ? user!.displayName ?? ''
            : _controllerNama.text.toString(),
      });

      Navigator.of(context).pop();

      // Uncomment the following lines if you want to update the password
      // await FirebaseAuth.instance.currentUser!.updatePassword(password);

      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Scaffold(
        backgroundColor: Colors.transparent, // Set background color to transparent
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
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              'Edit Profile',
              style: GoogleFonts.raleway(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      FutureBuilder<String>(
                        future: _loadProfileImage(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator(
                              color: Color.fromARGB(255, 0, 107, 152),
                            );
                          } else if (snapshot.hasData) {
                            final profilePictureUrl = snapshot.data!;
                            return CircleAvatar(
                              radius: 50,
                              backgroundImage: profilePictureUrl.isNotEmpty
                                  ? NetworkImage(profilePictureUrl)
                                      as ImageProvider<Object>?
                                  : const AssetImage('assets/images/card/minji.jpg'),
                            );
                          } else {
                            return const CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('assets/images/card/minji.jpg'),
                            );
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                        child: TextFormField(
                          controller: _controllerNama,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Insert your full name';
                            }
                            return null;
                          },
                  style: GoogleFonts.raleway(color: Colors.white),

                          decoration: InputDecoration(
                            border: const OutlineInputBorder(borderSide: BorderSide()),
                            labelText: 'Full Name',
                            labelStyle: GoogleFonts.raleway(color: const Color.fromARGB(255, 255, 255, 255)),
                            hintText: username ?? 'Loading...',
                            hintStyle: GoogleFonts.raleway(color: const Color.fromARGB(255, 255, 255, 255)),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255),
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
                  style: GoogleFonts.raleway(color: Colors.white),

                          controller: _controllerEmail,
                          enabled: false,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(borderSide: BorderSide()),
                            hintText: email ?? 'Loading...',
                            hintStyle: GoogleFonts.raleway(color: const Color.fromARGB(255, 255, 255, 255)),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255),
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
                          controller: _controllerOldPass,
                          obscureText: true,
                          enabled: false,
                  style: GoogleFonts.raleway(color: Colors.white),

                          decoration: InputDecoration(
                            border: const OutlineInputBorder(borderSide: BorderSide()),
                            hintText: '********',
                            hintStyle: GoogleFonts.raleway(color: const Color.fromARGB(255, 253, 253, 253)),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255),
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
                        padding: const EdgeInsets.all(50.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            handleSubmit();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 1, 13, 37),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            minimumSize: const Size(200, 50),
                          ),
                          child: Text(
                            'Update Now',
                            style: GoogleFonts.raleway(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
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