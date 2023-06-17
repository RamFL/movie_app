import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/ui/movie/movie_home.dart';
import 'package:movie_app/ui/tv/tv_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectIndex = 0;

  Widget getView() {
    if (_selectIndex == 0) {
      return MovieHome();
    } else {
      return TvHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Row(
          children: [
            const Icon(
              Icons.slow_motion_video_sharp,
              size: 30,
              color: Colors.pink,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              'Movies~',
              style: GoogleFonts.acme(fontSize: 25, color: Colors.pink),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.search, color: Colors.white, size: 25,),
          ),
        ],
      ),
      body: getView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectIndex,
        onTap: (index) {
          _selectIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.movie_filter_outlined,
                size: 25,
              ),
              label: 'Movie'),
          BottomNavigationBarItem(icon: Icon(Icons.tv, size: 25), label: 'TV'),
        ],
        backgroundColor: Colors.black54,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.white,
      ),
    );
  }
}
