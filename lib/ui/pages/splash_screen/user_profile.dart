// ignore_for_file: constant_identifier_names, camel_case_types, use_build_context_synchronously

import 'package:flutixapp/auth/auth.dart';
import 'package:flutixapp/ui/widgets/moviepref.dart';
import 'package:flutter/material.dart';

class uprof extends StatefulWidget {
  const uprof({Key? key}) : super(key: key);

  @override
  State<uprof> createState() => _uprofState();
}

enum MovieGenre { Horror, Music, Action, Drama, Adventure, Crime }

enum MovieLanguage { Indonesian, English, Japanase, Korean }

class _uprofState extends State<uprof> {
  Map<MovieGenre, Color> textColorMap = {
    MovieGenre.Horror: Colors.white,
    MovieGenre.Music: Colors.white,
    MovieGenre.Action: Colors.white,
    MovieGenre.Drama: Colors.white,
    MovieGenre.Adventure: Colors.white,
    MovieGenre.Crime: Colors.white,
  };

  Map<MovieLanguage, Color> languageColorMap = {
    MovieLanguage.Indonesian: Colors.white,
    MovieLanguage.English: Colors.white,
    MovieLanguage.Japanase: Colors.white,
    MovieLanguage.Korean: Colors.white,
  };

  List<MovieGenre> genrePref = [];
  List<MovieLanguage> languagePref = [];

  void _handleGenreTap(MovieGenre genre) {
    setState(() {
      if (genrePref.contains(genre)) {
        genrePref.remove(genre);
      } else {
        genrePref.add(genre);
      }
      textColorMap[genre] = (textColorMap[genre] == Colors.white)
          ? const Color.fromARGB(255, 0, 107, 152)
          : Colors.white;
    });
  }

  void _handleLanguageTap(MovieLanguage language) {
    setState(() {
      if (languagePref.contains(language)) {
        languagePref.remove(language);
      } else {
        languagePref.add(language);
      }
      languageColorMap[language] = (languageColorMap[language] == Colors.white)
          ? const Color.fromARGB(255, 0, 107, 152)
          : Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Wrap Scaffold with a Container for gradient background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 0, 107, 152),
              Color.fromARGB(255, 1, 3, 25),
              Color.fromARGB(255, 0, 107, 152)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(
                    text: "Select Your",
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                    ),
                const TextWidget(
                    text: "Genre", fontSize: 24, fontWeight: FontWeight.bold),
                Row(
                  children: [
                    GenreContainer(
                      imagePath: "assets/splash/horror.jpg",
                      label: "Horror",
                      textColor: textColorMap[MovieGenre.Horror]!,
                      onTap: () => _handleGenreTap(MovieGenre.Horror),
                    ),
                    GenreContainer(
                      imagePath: "assets/splash/music.jpeg",
                      label: "Music",
                      textColor: textColorMap[MovieGenre.Music]!,
                      onTap: () => _handleGenreTap(MovieGenre.Music),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GenreContainer(
                      imagePath: "assets/splash/action.jpg",
                      label: "Action",
                      textColor: textColorMap[MovieGenre.Action]!,
                      onTap: () => _handleGenreTap(MovieGenre.Action),
                    ),
                    GenreContainer(
                      imagePath: "assets/splash/drama.jpeg",
                      label: "Drama",
                      textColor: textColorMap[MovieGenre.Drama]!,
                      onTap: () => _handleGenreTap(MovieGenre.Drama),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GenreContainer(
                      imagePath: "assets/splash/adventure.jpeg",
                      label: "Adventure",
                      textColor: textColorMap[MovieGenre.Adventure]!,
                      onTap: () => _handleGenreTap(MovieGenre.Adventure),
                    ),
                    GenreContainer(
                      imagePath: "assets/splash/crime.jpeg",
                      label: "Crime",
                      textColor: textColorMap[MovieGenre.Crime]!,
                      onTap: () => _handleGenreTap(MovieGenre.Crime),
                    ),
                  ],
                ),
                const TextWidget(
                    text: "Which Movie Language",
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
                const TextWidget(
                    text: "You Prefer",
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
                Row(
                  children: [
                    LanguageContainer(
                      imagePath: "assets/splash/indo.jpg",
                      label: "Indonesian",
                      textColor: languageColorMap[MovieLanguage.Indonesian]!,
                      onTap: () => _handleLanguageTap(MovieLanguage.Indonesian),
                    ),
                    LanguageContainer(
                      imagePath: "assets/splash/english.jpg",
                      label: "English",
                      textColor: languageColorMap[MovieLanguage.English]!,
                      onTap: () => _handleLanguageTap(MovieLanguage.English),
                    ),
                  ],
                ),
                Row(
                  children: [
                    LanguageContainer(
                      imagePath: "assets/splash/japan.jpeg",
                      label: "Japanase",
                      textColor: languageColorMap[MovieLanguage.Japanase]!,
                      onTap: () => _handleLanguageTap(MovieLanguage.Japanase),
                    ),
                    LanguageContainer(
                      imagePath: "assets/splash/korea.jpg",
                      label: "Korean",
                      textColor: languageColorMap[MovieLanguage.Korean]!,
                      onTap: () => _handleLanguageTap(MovieLanguage.Korean),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextWidget(
                      text: "Back to main page",
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                    GestureDetector(
                      onTap: () async {
                        // Panggil metode savePreferences
                        await Auth().savePreferences(genrePref, languagePref);

                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.only(right: 35, top: 40, bottom: 40),
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
          ],
        ),
      ),
    );
  }
}
