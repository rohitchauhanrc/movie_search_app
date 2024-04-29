import 'package:flutter/material.dart';
import 'package:movie_app/widgets/description.dart';
import 'package:movie_app/utils/text.dart';

class TrendingMovies extends StatelessWidget {
  final List trending;

  const TrendingMovies({super.key, required this.trending});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const modified_text(
            text: "Trending Movies",
            size: 18,
            color: Colors.white,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 270,
            child: ListView.builder(
                itemCount: trending.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Description(
                                  name: trending[index]['original_name'],
                                  description: trending[index]['overview'],
                                  bannerurl: 'http://image.tmdb.org/t/p/w500' +
                                      trending[index]['backdrop_path'],
                                  posterurl: 'http://image.tmdb.org/t/p/w500' +
                                      trending[index]['poster_path'],
                                  vote: trending[index]['vote_average']
                                      .toString(),
                                  launch_on: trending[index]['release_date']
                                      .toString())));
                    },
                    child: trending[index]['original_name'] != null
                        ? SizedBox(
                            width: 140,
                            child: Column(
                              children: [
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'http://image.tmdb.org/t/p/w500' +
                                                  trending[index]
                                                      ['poster_path']))),
                                ),
                                modified_text(
                                  text: trending[index]['original_name'] ??
                                      'Loading',
                                  color: Colors.white70,
                                  size: 15,
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  );
                }),
          )
        ],
      ),
    );
  }
}
