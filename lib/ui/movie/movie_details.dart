import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/ui/movie/components/custom_play_button.dart';

import 'components/castitem_movie.dart';
import 'components/similar_movies.dart';

class MovieDetails extends StatelessWidget {
  final String title, bdpUrl, overview;
  final DateTime relaseDate;
  final double votes;
  final int movieID;

  const MovieDetails({
    super.key,
    required this.title,
    required this.bdpUrl,
    required this.overview,
    required this.relaseDate,
    required this.votes,
    required this.movieID,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child: CachedNetworkImage(
                    height: 240,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    imageUrl: 'https://image.tmdb.org/t/p/w500' + bdpUrl.toString(),
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                CustomPlayButton(mID: movieID),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                title,
                style: GoogleFonts.domine(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  RatingBarIndicator(
                    rating: votes,
                    itemBuilder: (context, index) {
                      return const Icon(
                        Icons.star,
                        color: Colors.amber,
                      );
                    },
                    itemCount: 5,
                    itemSize: 15,
                    direction: Axis.horizontal,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    votes.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Spacer(),
                  Text(
                    'Release Date:- ${DateFormat.yMMMd().format(
                      DateTime.parse(relaseDate.toString() ?? ""),
                    )}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                overview,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Cast',
                style: GoogleFonts.domine(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            CastItems(mID: movieID),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Similar Movies',
                style: GoogleFonts.domine(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SimilarMovies(mId: movieID),
          ],
        ),
      ),
    );
  }
}
