import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app_by_nainglinn/models/movies_response.dart';
import 'package:movie_app_by_nainglinn/utils/url_const.dart';

import '../cubits/movies_state.dart';
import '../cubits/popular_movies_cubit.dart';
import '../repositories/movie_repository.dart';
import '../utils/color_const.dart';

class MoviesGridView extends StatelessWidget {
  const MoviesGridView({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PopularMoviesCubit(
        movieRepo: MovieRepository(Dio()),
      )..getMovies(url),
      child: BlocBuilder<PopularMoviesCubit, MoviesState>(
        builder: (context, state) {
          return state.map(
            loading: (value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            data: (value) {
              return _BuildMovieGridView(
                movies: value.movies,
              );
            },
            error: (value) {
              return Center(child: Text(value.message.toString()));
            },
          );
        },
      ),
    );
  }
}

class _BuildMovieGridView extends StatelessWidget {
  final List<Movie> movies;
  const _BuildMovieGridView({required this.movies});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: movies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1 / 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) =>
            //         MovieDetailScreen(movie: movies[index]),
            //   ),
            // );
          },
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                    shape: BoxShape.rectangle,
                    image: movies[index].posterPath != null
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                UrlConst.imageUrl(movies[index].posterPath!)),
                          )
                        : null,
                  ),
                  child: movies[index].posterPath == null
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
                      movies[index].title ?? "movie name",
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
                              movies[index].voteAverage.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          RatingBar(
                            itemSize: 8.0,
                            ratingWidget: RatingWidget(
                              empty: const Icon(
                                EvaIcons.star,
                                color: AppColors.secondColor,
                              ),
                              full: const Icon(
                                EvaIcons.star,
                                color: AppColors.secondColor,
                              ),
                              half: const Icon(
                                EvaIcons.star,
                                color: AppColors.secondColor,
                              ),
                            ),
                            initialRating: movies[index].voteAverage! / 2,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            onRatingUpdate: (rating) {},
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        );
      },
    );
  }
}
