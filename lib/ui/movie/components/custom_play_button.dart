import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_models/videos_movie_model.dart'
    as VMModel;
import 'package:movie_app/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';



class CustomPlayButton extends StatefulWidget {
  final int mID;
  const CustomPlayButton({Key? key, required this.mID}) : super(key: key);

  @override
  State<CustomPlayButton> createState() => _CustomPlayButtonState();
}

class _CustomPlayButtonState extends State<CustomPlayButton> {
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: apiService.getVideoMovie(widget.mID ?? 0),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<VMModel.Result> videoList = snapshot.data!;

          if (videoList.isNotEmpty) {
            return CircleAvatar(
              child: IconButton(
                onPressed: () async {
                  if (!await launchUrl(Uri.parse(
                      'https://www.youtube.com/embed/${videoList[0].key}'))) {
                    throw Exception('Could not launch');
                  }
                },
                icon: const Icon(Icons.play_circle),
              ),
            );
          }
        }
        return const SizedBox();
      },
    );
  }
}
