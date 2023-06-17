import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/models/tv_models/top_rated_tv_model.dart';
import 'package:movie_app/services/api_service.dart';

class TopRatedTVShows extends StatefulWidget {

  const TopRatedTVShows({Key? key}) : super(key: key);

  @override
  State<TopRatedTVShows> createState() => _TopRatedTVShowsState();
}

class _TopRatedTVShowsState extends State<TopRatedTVShows> {
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: FutureBuilder(
        future: apiService.getTopRatedTV(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Result> moviesList = snapshot.data ?? [];


            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: moviesList.length,
              itemBuilder: (context, index) {
                var data = moviesList[index];
                return Column(
                  children: [
                    Container(
                      width: 140,
                      height: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "https://image.tmdb.org/t/p/w500" +
                                  data.posterPath),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 140,
                      child: Text(
                        data.originalName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RatingBarIndicator(
                          rating: data.voteAverage,
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
                          data.voteAverage == null
                              ? ""
                              : data.voteAverage.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
