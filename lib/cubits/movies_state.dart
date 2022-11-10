import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_app_by_nainglinn/models/movies_response.dart';

part 'movies_state.freezed.dart';

@freezed
class MoviesState with _$MoviesState {
  const factory MoviesState.loading() = _Loading;
  const factory MoviesState.data(List<Movie> movies) = _Data;
  const factory MoviesState.error(String message) = _Error;
}
