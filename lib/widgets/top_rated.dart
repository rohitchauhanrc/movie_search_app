import 'package:flutter/material.dart';
import 'package:movie_app/utils/text.dart';

import 'description.dart';

class TopRatedMovies extends StatelessWidget {
  final List toprated;

  const TopRatedMovies({super.key, required this.toprated});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const modified_text(
            text: "Top Rated Movies",
            size: 18,
            color: Colors.white,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 210,
            child: ListView.builder(
                itemCount: toprated.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Description(
                                  name: toprated[index]['title'],
                                  description:
                                      toprated[index]['overview'].toString(),
                                  bannerurl: 'http://image.tmdb.org/t/p/w500' +
                                      toprated[index]['backdrop_path'],
                                  posterurl: 'http://image.tmdb.org/t/p/w500' +
                                      toprated[index]['poster_path'],
                                  vote: toprated[index]['vote_average']
                                      .toString(),
                                  launch_on: toprated[index]['release_date']
                                      .toString())));
                    },
                    child: toprated[index]['title'] != null
                        ? Container(
                            padding: const EdgeInsets.all(5),
                            width: 250,
                            child: Column(
                              children: [
                                Container(
                                  width: 250,
                                  height: 140,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'http://image.tmdb.org/t/p/w500' +
                                                  toprated[index]
                                                      ['backdrop_path']),
                                          fit: BoxFit.cover)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                modified_text(
                                  text: toprated[index]['title'] ?? 'Loading',
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
