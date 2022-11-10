import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_by_nainglinn/cubits/movies_state.dart';
import 'package:movie_app_by_nainglinn/repositories/movie_repository.dart';

class PopularMoviesCubit extends Cubit<MoviesState> {
  PopularMoviesCubit({
    required this.movieRepo,
  }) : super(const MoviesState.loading());

  final MovieRepository movieRepo;

  getMovies(String url) async {
    final result = await movieRepo.getMovies(url);
    result.fold(
      (errorMsg) => emit(MoviesState.error(errorMsg)),
      (movies) => emit(MoviesState.data(movies)),
    );
  }
}
