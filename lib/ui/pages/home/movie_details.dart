// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutixapp/models/models.dart';
import 'package:flutixapp/services/services.dart';
import 'package:flutixapp/ui/widgets/moviedetails.dart';
import 'package:flutter/material.dart';

// ... (your existing imports)

class movie_details extends StatelessWidget {
  Movie movie;
  bool isComing;
  int? saldo;
  movie_details({super.key, required this.movie, required this.saldo, required this.isComing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: const [ Color.fromARGB(255, 0, 107, 152),
            Color.fromARGB(255, 1, 3, 25),
            Color.fromARGB(255, 0, 107, 152),
], // Adjust colors as needed
            ),
          ),
          child: ListView(
            children: [
              FutureBuilder<List<Movie>>(
                future: Api.getMovieDetails(movie.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      heightFactor: 25,
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 0, 107, 152),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final movies = snapshot.data!;
                    return MovieDetails(
                      movie: movies.first,
                      isComing: isComing,
                      saldo: saldo!,
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return Text("There is no data");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
