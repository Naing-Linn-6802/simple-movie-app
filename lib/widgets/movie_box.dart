import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_by_nainglinn/models/movies_response.dart';
import 'package:movie_app_by_nainglinn/widgets/rating_bar_widget.dart';

import '../pages/movie_detail_screen.dart';
import '../utils/url_const.dart';

class MovieBox extends StatelessWidget {
  const MovieBox({
    super.key,
    required this.movie,
  });
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailPage(movieId: movie.id!),
          ),
        );
      },
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                shape: BoxShape.rectangle,
                image: movie.posterPath != null
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                            UrlConst.imageUrl(movie.posterPath!)),
                      )
                    : null,
              ),
              child: movie.posterPath == null
                  ? const Icon(
                      EvaIcons.filmOutline,
                      color: Colors.white,
                      size: 60.0,
                    )
                  : null,
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Text(
                  movie.title ?? "movie name",
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Flexible(
                  child: Row(
                    children: <Widget>[
                      FittedBox(
                        child: Text(
                          movie.voteAverage.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      RatingBarWidget(voteAverage: movie.voteAverage!),
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
