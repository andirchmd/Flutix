import 'package:flutixapp/ui/widgets/moviecomingposter.dart';
import 'package:flutixapp/ui/widgets/movieposter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutixapp/models/models.dart';
import 'package:flutixapp/services/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

Color cardsColor = const Color(0xFFEAE9E7);

class _HomePageState extends State<HomePage> {
  String username = '';
  String profilePictureUrl = '';
  int? saldo;
  List<Movie> movies = [];

  List<Movie> comingSoonMovies = [];

  @override
  void initState() {
    super.initState();
    loadProfile();
    updateProfile();
  }

  Future<void> loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('nama') ?? "";
      profilePictureUrl = prefs.getString('profilePictureUrl') ?? "";
      saldo = prefs.getInt('saldo');
    });
  }

  Future<void> updateProfile() async {
    await loadProfile();
  }

  Future<String> _loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('profilePictureUrl') ?? "";
  }

  Widget _buildNowPlayingSection() {
    // Code for the "Now Playing" section
    Future<List<Movie>> nowPlaying = Api.getMovies('now_playing', 6);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 330,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Now Playing",
              style: GoogleFonts.raleway(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        FutureBuilder<List<Movie>>(
          future: nowPlaying,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                color: Color.fromARGB(255, 0, 107, 152),
              );
            } else if (snapshot.hasData) {
              final movies = snapshot.data!;
              return Container(
                height: 156,
                padding: const EdgeInsets.only(left: 20),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, i) {
                    return MoviePoster(
                      saldo: saldo!,
                      movie: movies[i],
                    );
                  },
                  itemCount: movies.length,
                ),
              );
            } else {
              return const Text("There is no data");
            }
          },
        ),
      ],
    );
  }

  Widget _buildMovieCategorySection() {
    // Code for the "Movie Category" section
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Movie Category",
            style: GoogleFonts.raleway(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 50,
                    height: 50,
                    color: cardsColor,
                    child: Image.asset("assets/images/card/action.png"),
                  ),
                ),
                Text(
                  "Action",
                  style: GoogleFonts.raleway(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const SizedBox(width: 20),
            Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 50,
                    height: 50,
                    color: cardsColor,
                    child: Image.asset("assets/images/card/battle.png"),
                  ),
                ),
                Text(
                  "Battle",
                  style: GoogleFonts.raleway(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const SizedBox(width: 20),
            Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 50,
                    height: 50,
                    color: cardsColor,
                    child: Image.asset("assets/images/card/sci-fi.png"),
                  ),
                ),
                Text(
                  "Sci-fi",
                  style: GoogleFonts.raleway(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const SizedBox(width: 20),
            Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 50,
                    height: 50,
                    color: cardsColor,
                    child: Image.asset("assets/images/card/kids.png"),
                  ),
                ),
                Text(
                  "Fantasy",
                  style: GoogleFonts.raleway(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildComingSoonSection() {
    // Code for the "Coming Soon" section
    Future<List<Movie>> comingSoon = Api.getMovies('upcoming', 6);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 360,
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Coming Soon",
            style: GoogleFonts.raleway(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        FutureBuilder<List<Movie>>(
          future: comingSoon,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                color: Color.fromARGB(255, 0, 107, 152),
              );
            } else if (snapshot.hasData) {
              final movies = snapshot.data!;
              return Container(
                height: 200,
                padding: const EdgeInsets.only(left: 20),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, i) {
                    return MovieComingPoster(
                      saldo: saldo!,
                      movie: movies[i],
                    );
                  },
                  itemCount: movies.length,
                ),
              );
            } else {
              return const Text("There is no data");
            }
          },
        ),
      ],
    );
  }

  Widget _buildHolidayPromo() {
    // Code for the "Holiday Promo" section
    return InkWell(
      onTap: () {},
      child: Stack(
        children: [
          SizedBox(
            width: 300,
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                "assets/images/card/holiday-promo.png",
                fit: BoxFit.fill,
                color: Colors.black.withOpacity(0.4),
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Holiday Promo",
                  style: GoogleFonts.raleway(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Min. Four User        ",
                  style: GoogleFonts.raleway(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
                Container(
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 20.0, bottom: 20.0),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 0, 32, 69),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                              radius: 30,
                              backgroundImage: profilePictureUrl.isNotEmpty
                                  ? NetworkImage(profilePictureUrl)
                                      as ImageProvider<Object>?
                                  : const AssetImage(
                                      "assets/images/card/minji.jpg"),
                            );
                          } else {
                            return const CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage("assets/images/card/minji.jpg"),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username ?? "Loading...",
                            style: GoogleFonts.raleway(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "IDR $saldo",
                            style: GoogleFonts.openSans(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildNowPlayingSection(),
                const SizedBox(height: 10),
                _buildMovieCategorySection(),
                const SizedBox(height: 20),
                _buildComingSoonSection(),
                const SizedBox(height: 25),
                _buildHolidayPromo(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
