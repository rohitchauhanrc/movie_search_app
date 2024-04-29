import 'package:flutter/material.dart';
import 'package:movie_app/utils/text.dart';

import 'description.dart';

class TvShows extends StatelessWidget {
  final List tv;

  const TvShows({super.key, required this.tv});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const modified_text(
            text: "Tv Shows",
            size: 18,
            color: Colors.white,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 270,
            child: ListView.builder(
                itemCount: tv.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Description(
                                  name: tv[index]['original_name'],
                                  description: tv[index]['overview'],
                                  bannerurl: 'http://image.tmdb.org/t/p/w500' +
                                      tv[index]['backdrop_path'],
                                  posterurl: 'http://image.tmdb.org/t/p/w500' +
                                      tv[index]['poster_path'],
                                  vote: tv[index]['vote_average'].toString(),
                                  launch_on:
                                      tv[index]['release_date'].toString())));
                    },
                    child: SizedBox(
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
                                            tv[index]['poster_path']))),
                          ),
                          modified_text(
                            text: tv[index]['original_name'] ?? 'Loading',
                            color: Colors.white70,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
