import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';



import '../../../models/tv_models/on_the_air_tv_model.dart';

class OnAirTVShows extends StatefulWidget {
  final List<Result> onAirTVShow;
  const OnAirTVShows({Key? key, required this.onAirTVShow})
      : super(key: key);

  @override
  State<OnAirTVShows> createState() => _OnAirTVShowsState();
}

class _OnAirTVShowsState extends State<OnAirTVShows> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: widget.onAirTVShow.length,
      itemBuilder: (context, itemIndex, pageViewIndex) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            width: double.infinity,
            fit: BoxFit.fill,
            imageUrl: 'https://image.tmdb.org/t/p/w500' +
                widget.onAirTVShow[itemIndex].posterPath.toString(),
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
