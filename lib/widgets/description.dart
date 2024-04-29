import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/utils/text.dart';


class Description extends StatelessWidget {
  final String name, description, bannerurl, posterurl, vote, launch_on;

  const Description(
      {super.key,
      required this.name,
      required this.description,
      required this.bannerurl,
      required this.posterurl,
      required this.vote,
      required this.launch_on});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 250,
            child: Stack(
              children: [
                Positioned(
                    child: SizedBox(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    bannerurl,
                    fit: BoxFit.fill,
                  ),
                )),
                Positioned(
                    bottom: 10,
                    child: modified_text(
                      text:
                          " ⭐ Average Rating - ${double.parse(vote).toStringAsFixed(1)}",
                      color: Colors.white,
                      size: 12,
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
              padding: const EdgeInsets.all(15),
              child: Text(
                name ?? 'Not Loaded',
                style: const TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 24),
              )),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: modified_text(
              text: "Release - $launch_on",
              color: Colors.white,
              size: 15,
            ),
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                height: 200,
                width: 100,
                child: Image.network(posterurl),
              ),
              Flexible(
                child: Container(
                  child: Text(
                    description,
                    style: GoogleFonts.roboto(
                      color: Colors.white70,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
