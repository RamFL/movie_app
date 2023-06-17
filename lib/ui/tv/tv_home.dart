import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/models/tv_models/on_the_air_tv_model.dart';

import 'package:movie_app/services/api_service.dart';

import 'components/airing_today_tvshow.dart';
import 'components/popular_tvshow.dart';
import 'components/top_rated_tvshow.dart';
import 'components/tv_carousel.dart';

class TvHome extends StatefulWidget {
  const TvHome({Key? key}) : super(key: key);

  @override
  State<TvHome> createState() => _TvHomeState();
}

class _TvHomeState extends State<TvHome> {
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
            future: apiService.getOnTheAirTV(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Result> tvData = snapshot.data!;
                return OnAirTVShows(
                  onAirTVShow: tvData,
                );
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
                  'Airing Today',
                  style: GoogleFonts.domine(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const AiringTodayTVShows(),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Top Rated TV Shows',
                  style: GoogleFonts.domine(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const TopRatedTVShows(),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Popular TV Shows',
                  style: GoogleFonts.domine(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const PopularTVShows(),
            ],
          ),
        ],
      ),
    );
  }
}
