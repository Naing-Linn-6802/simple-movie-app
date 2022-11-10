import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_app_by_nainglinn/models/movie_detail.dart';

part 'movie_detail_state.freezed.dart';

@freezed
class MovieDetailState with _$MovieDetailState {
  const factory MovieDetailState.loading()=_Loading;
  const factory MovieDetailState.data(MovieDetail movieDetail) = _Data;
  const factory MovieDetailState.error(String message)=_Error;
}