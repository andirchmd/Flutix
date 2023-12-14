// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutixapp/ui/pages/home/edit_profile.dart';
import 'package:flutixapp/ui/pages/home/myWallet.dart';
import 'package:flutixapp/ui/pages/splash_screen/splash-screen.dart';
import 'package:flutixapp/ui/pages/splash_screen/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key, Key});

  @override
  State<ProfilPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilPage> {
  String username = '';
  String email = '';
  String profilePictureUrl = '';

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('nama') ?? "";
      email = prefs.getString('email') ?? "";
      profilePictureUrl = prefs.getString('profilePictureUrl') ?? "";
    });
  }

  Future<String> _loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('profilePictureUrl') ?? "";
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
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
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
                                  : const AssetImage(
                                      "assets/images/card/minji.jpg"),
                            );
                          } else {
                            return CircleAvatar(
                              radius: 50,
                              backgroundImage: const AssetImage(
                                  "assets/images/card/minji.jpg"),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      Text(
                        username ?? "Loading...",
                        style: GoogleFonts.raleway(fontSize: 24,color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        email ?? "Loading...",
                        style: GoogleFonts.raleway(fontSize: 16,color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {}, 
                              icon: Icon(Icons.settings),
                              color: Colors.white,),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfile()),
                                );
                              },
                              style: TextButton.styleFrom(
                                  foregroundColor: const Color.fromARGB(255, 250, 249, 249)),
                              child: Text(
                                "Edit Profile",
                                style: GoogleFonts.raleway(fontSize: 16),
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {}, 
                              icon: Icon(Icons.wallet),
                              color: Colors.white,),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => myWallet()),
                                );
                              },
                              style: TextButton.styleFrom(
                                  foregroundColor: const Color.fromARGB(255, 255, 255, 255)),
                              child: Text(
                                "My Wallet",
                                style: GoogleFonts.raleway(fontSize: 16),
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => uprof()),
                                );
                              },
                              icon: Icon(Icons.language),
                              color: Colors.white,),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => uprof()),
                                );
                              },
                              style: TextButton.styleFrom(
                                  foregroundColor: const Color.fromARGB(255, 255, 255, 255)),
                              child: Text(
                                "Change Language",
                                style: GoogleFonts.raleway(fontSize: 16),
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {}, 
                              icon: Icon(Icons.help_center),
                              color: Colors.white),
                          TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  foregroundColor: const Color.fromARGB(255, 255, 255, 255)),
                              child: Text(
                                "Help Center",
                                style: GoogleFonts.raleway(fontSize: 16),
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {}, 
                              icon: Icon(Icons.rate_review),
                              color: Colors.white,),
                          TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  foregroundColor: const Color.fromARGB(255, 255, 255, 255)),
                              child: Text(
                                "Rate Flutix App",
                                style: GoogleFonts.raleway(fontSize: 16),
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return splash();
                                    },
                                  ),
                                );
                              },
                              icon: Icon(Icons.logout),
                              color: Colors.white),
                          TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return splash();
                                    },
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                  foregroundColor: const Color.fromARGB(255, 255, 255, 255)),
                              child: Text(
                                "Log out",
                                style: GoogleFonts.raleway(fontSize: 16),
                              )),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}