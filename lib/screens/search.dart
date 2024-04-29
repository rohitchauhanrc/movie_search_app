import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../widgets/description.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<String>> _searchResults;

  @override
  void initState() {
    super.initState();
    _searchResults = Future.value([]); // Initialize with an empty list
  }

  void searchMovies(String query) {
    setState(() {
      _searchResults = TMDBService.searchMovies(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Center(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search for a movie...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: searchMovies,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder(
                future: _searchResults, // Use future for async search results
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final List<String> movies = snapshot.data as List<String>;
                    return ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(movies[index]),
                          onTap: () async {
                            final selectedMovie = snapshot.data![index];
                            final movieDetails =
                                await TMDBService.fetchMovieDetails(
                                    selectedMovie);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Description(
                                  name: movieDetails['title'],
                                  description: movieDetails['overview'],
                                  bannerurl:
                                      'https://image.tmdb.org/t/p/w500${movieDetails['backdrop_path']}',
                                  posterurl:
                                      'https://image.tmdb.org/t/p/w500${movieDetails['poster_path']}',
                                  vote: movieDetails['vote_average'].toString(),
                                  launch_on: movieDetails['release_date'],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('No results found'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TMDBService {
  static const String apiKey = "9973b0dfecd18d89193dbc104f9d859c";

  static Future<List<String>> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((e) => e['title'] as String).toList();
    } else {
      throw Exception('Failed to load movie suggestions');
    }
  }

  static Future<Map<String, dynamic>> fetchMovieDetails(String title) async {
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$title'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['results'];
      if (data.isNotEmpty) {
        final movieId = data[0]['id'];
        final movieDetailsResponse = await http.get(
          Uri.parse(
              'https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey'),
        );

        if (movieDetailsResponse.statusCode == 200) {
          return json.decode(movieDetailsResponse.body);
        } else {
          throw Exception('Failed to load movie details');
        }
      } else {
        throw Exception('Movie not found');
      }
    } else {
      throw Exception('Failed to load movie suggestions');
    }
  }
}
