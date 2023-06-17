import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_models/cast_movie_model.dart' as CMModel;
import 'package:movie_app/services/api_service.dart';

class CastItems extends StatefulWidget {
  final int mID;
  const CastItems({Key? key, required this.mID}) : super(key: key);

  @override
  State<CastItems> createState() => _CastItemsState();
}

class _CastItemsState extends State<CastItems> {
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: FutureBuilder(
        future: apiService.getCastMovie(widget.mID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CMModel.Cast> castList = snapshot.data!;

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: castList.length,
              itemBuilder: (context, index) {
                var castData = castList[index];

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundImage: castData.profilePath != null
                            ? NetworkImage("https://image.tmdb.org/t/p/w500" +
                                castData.profilePath.toString())
                            : NetworkImage('url'),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        castData.name,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        castData.knownForDepartment,
                        style: const TextStyle(
                          color: Colors.white54,
                        ),
                      )
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
