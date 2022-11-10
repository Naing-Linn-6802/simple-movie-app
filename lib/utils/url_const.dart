class UrlConst {
  static const String mainUrl = "https://api.themoviedb.org/3";
  static const String _apiKey = "a92f28e11a27e8e5938a2020be68ba9c";
  static const String _param = "?api_key=$_apiKey&language=en-US";
  static const String nowPlayingMovieUrl = "$mainUrl/movie/now_playing$_param";
  static const String popularMovieUrl = "$mainUrl/movie/popular$_param";
  static const String topRatedMovieUrl = "$mainUrl/movie/top_rated$_param";
  static const String upcomingMovieUrl = "$mainUrl/movie/upcoming$_param";

  static String movieDetailUrl(int movieId) => "$mainUrl/movie/$movieId$_param";
  static String imageUrl(String path) =>
      "https://image.tmdb.org/t/p/w200/$path";
}
