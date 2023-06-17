import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/constants/constant.dart';
import 'package:movie_app/models/movie_models/movie_model.dart' as movieModel;
import 'package:movie_app/models/movie_models/popular_movie_model.dart';
import 'package:movie_app/models/movie_models/similar_movie_model.dart' as SMMModel;
import 'package:movie_app/models/movie_models/videos_movie_model.dart' as VMModel;
import 'package:movie_app/models/movie_models/cast_movie_model.dart' as CMModel;
import 'package:movie_app/models/movie_models/top_rated_movie_model.dart' as TRMModel;
import 'package:movie_app/models/movie_models/upcoming_movie_model.dart' as UPMModel;
import 'package:movie_app/models/tv_models/on_the_air_tv_model.dart' as OATVModel;
import 'package:movie_app/models/tv_models/airing_today_tv_model.dart' as ATTVModel;
import 'package:movie_app/models/tv_models/top_rated_tv_model.dart' as TRTVModel;
import 'package:movie_app/models/tv_models/popular_tv_model.dart' as PTVModel;


enum MovieType { nowPlaying, popular, topRated, upcoming }

class ApiService {

  // For Movies
  // To get Now playing Movies List
  Future<List<movieModel.Result>> getNowPlayingMovie() async {

    String url = kmovieDbURL + know_playing;

    // if (type == MovieType.nowPlaying) {
    //   url = kmovieDbURL + know_playing;
    // } else if (type == MovieType.upcoming) {
    //   url = kmovieDbURL + kupcoming;
    // }
    // else if (type == MovieType.topRated) {
    //   url = kmovieDbURL + ktop_rated;
    // } else if (type == MovieType.upcoming) {
    //   url = kmovieDbURL + kupcoming;
    // }

    // try {
    //   print(url+ '?api_key=daa058cd786bc60a86cd411c60ccd43e');
    //
    //   Response response = await get(
    //       Uri.parse(url+ '?api_key=daa058cd786bc60a86cd411c60ccd43e'));
    //
    //   if (response.statusCode == 200) {
    //     print('Status 200');
    //     Map<String, dynamic> json = jsonDecode(response.body);
    //     print('Response decoded');
    //     List<dynamic> body = json['results'];
    //     print('Result received');
    //
    //     List<Result> movieList =
    //         body.map((dynamic item) => Result.fromJson(item)).toList();
    //
    //     print('movieList decoded');
    //
    //     print(movieList.length);
    //
    //     return movieList;
    //   } else {
    //     print("request problem");
    //     throw ("No Movies Found");
    //   }
    // } catch (e) {
    //   throw e.toString();
    // }

    print(url+'?api_key=daa058cd786bc60a86cd411c60ccd43e');



    var request = http.Request(
        'GET',
        Uri.parse(url+'?api_key=daa058cd786bc60a86cd411c60ccd43e'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      var result = await response.stream.bytesToString();

      movieModel.MoviesResult moviesResult = movieModel.moviesResultFromJson(result);

      print("now playing Movie List Generated");

      return moviesResult.results;
    } else {
      print("request problem");
      print(response.reasonPhrase.toString());
      throw response.reasonPhrase.toString();
    }
  }

  //To Get popular movies List
  Future<List<Result>> getPopularMovie() async {

    String url = kmovieDbURL + kpopular;

    var request = http.Request(
        'GET',
        Uri.parse(url + '?api_key=daa058cd786bc60a86cd411c60ccd43e'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      var result = await response.stream.bytesToString();

      PopularMovieModel popularMovieModel = PopularMovieModel.fromJson(
          jsonDecode(result));

      print("popular Movie List Generated");

      return popularMovieModel.results;
    } else {
      print("request problem");
      print(response.reasonPhrase.toString());
      throw response.reasonPhrase.toString();
    }
  }



    //To Get upcoming movies
    Future<List<UPMModel.Result>> getUpcomingMovie() async {

      String url = kmovieDbURL + kupcoming;

      var request = http.Request(
          'GET',
          Uri.parse(url+'?api_key=daa058cd786bc60a86cd411c60ccd43e'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {

        var result = await response.stream.bytesToString();

        UPMModel.UpcomingMovieModel upcomingMovieModel = UPMModel.UpcomingMovieModel.fromJson(jsonDecode(result));

        print("Upcoming Movie List Generated");

        return upcomingMovieModel.results;
      } else {
        print("request problem");
        print(response.reasonPhrase.toString());
        throw response.reasonPhrase.toString();
      }
  }


  // To Get top rated movies
  Future<List<TRMModel.Result>> getTopRatedMovie() async {


    String url = kmovieDbURL + ktop_rated;


    var request = http.Request(
        'GET',
        Uri.parse(url+'?api_key=daa058cd786bc60a86cd411c60ccd43e'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      var result = await response.stream.bytesToString();

      TRMModel.TopRatedMovieModel topRatedMovieModel = TRMModel.TopRatedMovieModel.fromJson(jsonDecode(result));

      print("Top Rated Movie List Generated");

      return topRatedMovieModel.results;
    } else {
      print("request problem");
      print(response.reasonPhrase.toString());
      throw response.reasonPhrase.toString();
    }
  }

  // To Get Similar movies
  Future<List<SMMModel.Result>> getSimilarMovie(int movieId) async {


    String url = kmovieDbURL + movieId.toString() + ksimilar;


    print(
        url+'?api_key=daa058cd786bc60a86cd411c60ccd43e');


    // var request = http.Request(
    //     'GET',
    //     Uri.parse(url+'?api_key=daa058cd786bc60a86cd411c60ccd43e'));
    //
    // http.StreamedResponse response = await request.send();

    http.Response response = await http.get(Uri.parse(url+'?api_key=daa058cd786bc60a86cd411c60ccd43e'));

    if (response.statusCode == 200) {
      print("Silimar status 200");

      // var result = await response.stream.bytesToString();

      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['results'];

      print('Similar -- $body');

      // SMMModel.SimilarMovieModel similarMovieModel = SMMModel.SimilarMovieModel.fromJson(json.decode(result));

      List<SMMModel.Result> similarList = body.map((x) => SMMModel.Result.fromJson(x)).toList();

      //List<Result> movieList =
    //         body.map((dynamic item) => Result.fromJson(item)).toList();
      print("Similar Movie List Generated");

      return similarList;
    } else {
      print("request problem");
      print(response.reasonPhrase.toString());
      throw response.reasonPhrase.toString();
    }
  }

  // To Get Trailer videos of movies
  Future<List<VMModel.Result>> getVideoMovie(int movieId) async {


    String url = kmovieDbURL + movieId.toString() + kvideos;


    print(
        url+'?api_key=daa058cd786bc60a86cd411c60ccd43e');


    http.Response response = await http.get(Uri.parse(url+'?api_key=daa058cd786bc60a86cd411c60ccd43e'));

    if (response.statusCode == 200) {
      print("Video status 200");

      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['results'];

      print('Videos -- $body');

      List<VMModel.Result> videosList = body.map((x) => VMModel.Result.fromJson(x)).toList();

      print("Video List Generated");

      return videosList;
    } else {
      print("request problem");
      print(response.reasonPhrase.toString());
      throw response.reasonPhrase.toString();
    }
  }

  // To Get cast models
  Future<List<CMModel.Cast>> getCastMovie(int movieId) async {


    String url = kmovieDbURL + movieId.toString() + kcast;


    print(
        url+'?api_key=daa058cd786bc60a86cd411c60ccd43e');


    http.Response response = await http.get(Uri.parse(url+'?api_key=daa058cd786bc60a86cd411c60ccd43e'));

    if (response.statusCode == 200) {
      print("Cast status 200");

      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['cast'];

      print('Cast -- $body');

      List<CMModel.Cast> castList = body.map((x) => CMModel.Cast.fromJson(x)).toList();

      print("castList List Generated");

      return castList;
    } else {
      print("request problem");
      print(response.reasonPhrase.toString());
      throw response.reasonPhrase.toString();
    }
  }






  // For TV Shows
  // To get On the air tv shows
  Future<List<OATVModel.Result>> getOnTheAirTV() async {
    print("TV API started");

    String url = ktvDbURL + kon_the_air;


    print(
        url+'?api_key=daa058cd786bc60a86cd411c60ccd43e');


    var request = http.Request(
        'GET',
        Uri.parse(url+'?api_key=daa058cd786bc60a86cd411c60ccd43e'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("Status 200");

      var result = await response.stream.bytesToString();
      print("OTA Result Fetched");
      print(result);

      OATVModel.OnTheAirTvModel onTheAirTvModel = OATVModel.OnTheAirTvModel.fromJson(jsonDecode(result));

      print("OTA TV List Generated");

      return onTheAirTvModel.results;
    } else {
      print("request problem");
      print(response.reasonPhrase.toString());
      throw response.reasonPhrase.toString();
    }
  }


  // To get Airing Today tv shows
  Future<List<ATTVModel.Result>> getAiringTodayTV() async {
    print("ATTV API started");

    String url = ktvDbURL + kairing_today;


    print(
        url+'?api_key=daa058cd786bc60a86cd411c60ccd43e');


    var request = http.Request(
        'GET',
        Uri.parse(url+'?api_key=daa058cd786bc60a86cd411c60ccd43e'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("Status 200");

      var result = await response.stream.bytesToString();
      print("AT Result Fetched");
      print(result);

      ATTVModel.AiringTodayTvModel airingTodayTvModel = ATTVModel.AiringTodayTvModel.fromJson(jsonDecode(result));

      print("AT TV List Generated");

      return airingTodayTvModel.results;
    } else {
      print("request problem");
      print(response.reasonPhrase.toString());
      throw response.reasonPhrase.toString();
    }
  }

  // To get Top Rated tv shows
  Future<List<TRTVModel.Result>> getTopRatedTV() async {
    print("TRTV API started");

    String url = ktvDbURL + ktop_rated;


    print(
        url+'?api_key=daa058cd786bc60a86cd411c60ccd43e');


    var request = http.Request(
        'GET',
        Uri.parse(url+'?api_key=daa058cd786bc60a86cd411c60ccd43e'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("Status 200");

      var result = await response.stream.bytesToString();
      print("TR Result Fetched");
      print(result);

      TRTVModel.TopRatedTvModel topRatedTvModel = TRTVModel.TopRatedTvModel.fromJson(jsonDecode(result));

      print("TR TV List Generated");

      return topRatedTvModel.results;
    } else {
      print("request problem");
      print(response.reasonPhrase.toString());
      throw response.reasonPhrase.toString();
    }
  }


  // To get Popular tv shows
  Future<List<PTVModel.Result>> getPopularTV() async {
    print("PTV API started");

    String url = ktvDbURL + kpopular;


    print(
        url+'?api_key=daa058cd786bc60a86cd411c60ccd43e');


    var request = http.Request(
        'GET',
        Uri.parse(url+'?api_key=daa058cd786bc60a86cd411c60ccd43e'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("Status 200");

      var result = await response.stream.bytesToString();
      print("Popular Result Fetched");
      print(result);

      PTVModel.PopularTvModel popularTvModel = PTVModel.PopularTvModel.fromJson(jsonDecode(result));

      print("Popular TV List Generated");

      return popularTvModel.results;
    } else {
      print("request problem");
      print(response.reasonPhrase.toString());
      throw response.reasonPhrase.toString();
    }
  }
}
