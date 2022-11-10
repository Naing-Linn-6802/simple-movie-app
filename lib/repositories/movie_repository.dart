import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app_by_nainglinn/models/movie_detail.dart';
import 'package:movie_app_by_nainglinn/models/movies_response.dart';
import 'package:movie_app_by_nainglinn/utils/dio_error.dart';
import 'package:movie_app_by_nainglinn/utils/url_const.dart';

class MovieRepository {
  MovieRepository(this.client);
  final Dio client;

  Future<Either<String, List<Movie>>> getMovies(String url) async {
    try {
      final resp = await client.get(url);
      final parsedData = MoviesResponse.fromJson(resp.data);
      return right(parsedData.movies ?? []);
    } on DioError catch (e) {
      final msg = e.response?.data?["status_message"] ??
          DioErrorException.fromDioError(e).message;
      return left(msg);
    }
  }

  Future<Either<String, MovieDetail>> getMovieDetail(int movieId) async {
    try {
      final resp = await client.get(UrlConst.movieDetailUrl(movieId));
      final movieDetail = MovieDetail.fromJson(resp.data);
      return right(movieDetail);
    } on DioError catch (e) {
      final msg = e.response?.data?["status_message"] ??
          DioErrorException.fromDioError(e).message;
      return left(msg);
    }
  }
}
