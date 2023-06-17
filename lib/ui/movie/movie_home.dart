import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:movie_app/services/api_service.dart';
import 'package:movie_app/ui/movie/components/movie_carousel.dart';
import 'package:movie_app/ui/movie/components/popular_movies.dart';
import 'package:movie_app/models/movie_models/upcoming_movie_model.dart' as UPMModel;

import 'components/now_playing_movies.dart';
import 'components/top_rated_movies.dart';

class MovieHome extends StatefulWidget {
  const MovieHome({Key? key}) : super(key: key);

  @override
  State<MovieHome> createState() => _MovieHomeState();
}

class _MovieHomeState extends State<MovieHome> {
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          FutureBuilder(
            future: apiService.getUpcomingMovie(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<UPMModel.Result> movieData = snapshot.data!;
                return UpcomingMovies(upcomingMovies: movieData);
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Now Playing Movies',
                  style: GoogleFonts.domine(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
               const NowPlayingMovies(),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Top Rated Movies',
                  style: GoogleFonts.domine(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
               const TopRatedMovies(),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Popular Movies',
                  style: GoogleFonts.domine(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const PopularMovies(),
            ],
          ),
        ],
      ),
    );
  }
}
