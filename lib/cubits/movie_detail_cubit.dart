import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_movie_app/cubits/movie_detail_state.dart';
import 'package:simple_movie_app/repositories/movie_repository.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit({
    required this.movieRepo,
    required this.movieId,
  }) : super(const MovieDetailState.loading());
  final int movieId;
  final MovieRepository movieRepo;

  getMovies() async {
    final result = await movieRepo.getMovieDetail(movieId);
    result.fold(
      (errorMsg) => emit(MovieDetailState.error(errorMsg)),
      (movie) => emit(MovieDetailState.data(movie)),
    );
  }
}
