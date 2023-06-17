import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';



import '../../../models/movie_models/upcoming_movie_model.dart';

class UpcomingMovies extends StatefulWidget {
  final List<Result> upcomingMovies;
  const UpcomingMovies({Key? key, required this.upcomingMovies})
      : super(key: key);

  @override
  State<UpcomingMovies> createState() => _UpcomingMoviesState();
}

class _UpcomingMoviesState extends State<UpcomingMovies> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: widget.upcomingMovies.length,
      itemBuilder: (context, itemIndex, pageViewIndex) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            width: double.infinity,
            fit: BoxFit.fill,
            imageUrl: 'https://image.tmdb.org/t/p/w500' +
                widget.upcomingMovies[itemIndex].posterPath.toString(),
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        );
      },
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
      ),
    );
  }
}
