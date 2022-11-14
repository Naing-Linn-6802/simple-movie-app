import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_movie_app/models/movies_response.dart';
import 'package:simple_movie_app/widgets/movie_box.dart';

import '../cubits/movies_state.dart';
import '../cubits/popular_movies_cubit.dart';
import '../repositories/movie_repository.dart';

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
      itemBuilder: (context, index) => MovieBox(movie: movies[index]),
    );
  }
}
