import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/models/movie_models/similar_movie_model.dart';
import 'package:movie_app/services/api_service.dart';
import 'package:movie_app/ui/movie/movie_details.dart';

class SimilarMovies extends StatefulWidget {
  final int mId;

  const SimilarMovies({Key? key, required this.mId}) : super(key: key);

  @override
  State<SimilarMovies> createState() => _SimilarMoviesState();
}

class _SimilarMoviesState extends State<SimilarMovies> {
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: FutureBuilder(
        future: apiService.getSimilarMovie(widget.mId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Result> moviesList = snapshot.data!;

            print("similar movieList Received");

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: moviesList.length,
              itemBuilder: (context, index) {
                var data = moviesList[index];
                return InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetails(
                          title: data.originalTitle,
                          bdpUrl: data.backdropPath != null ? data.backdropPath! : data.posterPath!,
                          overview: data.overview,
                          relaseDate: data.releaseDate,
                          votes: data.voteAverage,
                          movieID: data.id,
                        ),
                      ),
                    );
                  },
                  child: Column(
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
                                    data.posterPath.toString()),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 140,
                        child: Text(
                          data.originalTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                : data.voteAverage.roundToDouble().toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
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
