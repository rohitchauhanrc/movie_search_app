import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/screens/profile.dart';
import 'package:movie_app/screens/search.dart';
import 'package:movie_app/screens/splash_screen.dart';
import 'package:movie_app/screens/recommend.dart';
import 'package:movie_app/widgets/top_rated.dart';
import 'package:movie_app/widgets/trending.dart';
import 'package:movie_app/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.green,
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List trendingMovies = [];
  List topRatedMovies = [];
  List tv = [];

  int _currentIndex = 0;

  final String apiKey = "9973b0dfecd18d89193dbc104f9d859c";
  final String readAccessToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5OTczYjBkZmVjZDE4ZDg5MTkzZGJjMTA0ZjlkODU5YyIsInN1YiI6IjY2MmM4YTI1MzU4MTFkMDEyOGU3YzQ4ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.3wK2uphvNhIzOcyDHLlSUew38YFF7XtEfa6k33QTBOw";

  void initState() {
    loadMovies();
    super.initState();
  }

  loadMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, readAccessToken),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));
    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvresult = await tmdbWithCustomLogs.v3.tv.getPopular();

    setState(() {
      trendingMovies = trendingresult['results'];
      topRatedMovies = topratedresult['results'];
      tv = tvresult['results'];
    });
    print(trendingMovies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _currentIndex == 0
          ? AppBar(
              backgroundColor: Colors.black54,
              title: Row(
                children: [
                  Image.asset(
                    'assets/images/appBarCinemania.png', // Path to your logo image
                    height: 38, // Adjust the height as needed
                    width: 38, // Adjust the width as needed
                  ),
                  const SizedBox(
                      width:
                          3), // Add some space between the logo and the title
                  Text(
                    "Cinemania",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    // Handle notification button press
                  },
                ),
              ],
            )
          : null,
      body: _currentIndex == 0
          ? ListView(
              children: [
                TopRatedMovies(
                  toprated: topRatedMovies,
                ),
                TrendingMovies(
                  trending: trendingMovies,
                ),
                TvShows(
                  tv: tv,
                )
              ],
            )
          : _currentIndex == 1
              ? SearchPage()
              : _currentIndex == 2
                  ? const MovieRecommendationsScreen(movieId: 550)
                  : ProfilePage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70.withOpacity(0.5),
        // Change text and icon color when not selected
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.film_fill),
            label: 'Recommendation',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_alt),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
