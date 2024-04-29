import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../widgets/description.dart';
import '../utils/text.dart';

Future<List<dynamic>> fetchMovieRecommendations(int movieId) async {
  const String apiKey = "9973b0dfecd18d89193dbc104f9d859c";
  const String readAccessToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5OTczYjBkZmVjZDE4ZDg5MTkzZGJjMTA0ZjlkODU5YyIsInN1YiI6IjY2MmM4YTI1MzU4MTFkMDEyOGU3YzQ4ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.3wK2uphvNhIzOcyDHLlSUew38YFF7XtEfa6k33QTBOw";

  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(
      apiKey,
      readAccessToken,
    ),
    logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true),
  );
  Map recommendationsResult =
      await tmdbWithCustomLogs.v3.movies.getRecommended(movieId);
  List recommendations = recommendationsResult['results'];
  return recommendations;
}

class MovieRecommendationsScreen extends StatefulWidget {
  final int movieId;

  const MovieRecommendationsScreen({Key? key, required this.movieId})
      : super(key: key);

  @override
  _MovieRecommendationsScreenState createState() =>
      _MovieRecommendationsScreenState();
}

class _MovieRecommendationsScreenState
    extends State<MovieRecommendationsScreen> {
  List<dynamic>? recommendations;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    recommendations = await fetchMovieRecommendations(widget.movieId);
    setState(() {});
  }

  void _onTap(int index) {
    if (recommendations == null || recommendations![index] == null) return;

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Description(
                name: recommendations![index]['original_name'] ?? '',
                description: recommendations![index]['overview'] ?? '',
                bannerurl: 'http://image.tmdb.org/t/p/w500' +
                    (recommendations![index]['backdrop_path'] ?? ''),
                posterurl: 'http://image.tmdb.org/t/p/w500' +
                    (recommendations![index]['poster_path'] ?? ''),
                vote: recommendations![index]['vote_average'].toString() ?? '',
                launch_on: recommendations![index]['release_date'] ?? '')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('Suggestion'),
      ),
      body: recommendations == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: recommendations!.length,
              itemBuilder: (context, index) {
                return ListTile(
                    onTap: () {
                      _onTap(index);
                    },
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500${recommendations![index]['poster_path']}'),
                        ),
                      ),
                    ),
                    title: Text(recommendations![index]['title'] ?? 'Loading',
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 18)),
                    subtitle: Row(
                      children: [
                        modified_text(
                          text: recommendations![index]['original_language'] ??
                              'Loading',
                          color: Colors.white38,
                          size: 12,
                        ),
                        const SizedBox(width: 10),
                        modified_text(
                          text:
                              'Vote: ${recommendations![index]['vote_average'].toString() ?? 'Loading'}',
                          color: Colors.white70,
                          size: 12,
                        ),
                      ],
                    ));
              },
            ),
    );
  }
}
