import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_by_nainglinn/models/movie_detail.dart';
import 'package:movie_app_by_nainglinn/repositories/movie_repository.dart';
import 'package:movie_app_by_nainglinn/utils/theme.dart';
import 'package:movie_app_by_nainglinn/utils/url_const.dart';
import 'package:movie_app_by_nainglinn/widgets/rating_bar_widget.dart';

import '../cubits/movie_detail_cubit.dart';
import '../cubits/movie_detail_state.dart';

class MovieDetailPage extends StatelessWidget {
  final int movieId;
  const MovieDetailPage({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => MovieDetailCubit(
          movieRepo: MovieRepository(Dio()),
          movieId: movieId,
        )..getMovies(),
        child: BlocBuilder<MovieDetailCubit, MovieDetailState>(
          builder: (context, state) {
            return state.map(
              loading: (_) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              data: (value) {
                final movie = value.movieDetail;
                return CustomScrollView(
                  slivers: <Widget>[
                    _BuildAppBar(movie: movie),
                    _BuildMovieInfoList(movie: movie),
                  ],
                );
              },
              error: (value) {
                return Center(child: Text(value.message));
              },
            );
          },
        ),
      ),
    );
  }
}

class _BuildMovieInfoList extends StatelessWidget {
  const _BuildMovieInfoList({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final MovieDetail movie;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(15),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  movie.voteAverage!.toStringAsFixed(1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                RatingBarWidget(voteAverage: movie.voteAverage!)
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              "OVERVIEW",
              style: AppTheme.greyTileStyle,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              movie.overview!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13.0,
                height: 1.5,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text("DURATION", style: AppTheme.greyTileStyle),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "${movie.runtime}min",
                      style: AppTheme.yellowTitleStyle,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text("RELEASE DATE", style: AppTheme.greyTileStyle),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      movie.releaseDate!,
                      style: AppTheme.yellowTitleStyle,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            _BuildGenres(movie: movie),
          ],
        ),
      ),
    );
  }
}

class _BuildGenres extends StatelessWidget {
  const _BuildGenres({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final MovieDetail movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text("GENRES", style: AppTheme.greyTileStyle),
        const SizedBox(
          height: 10.0,
        ),
        SizedBox(
          height: 40.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movie.genres!.length,
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5.0),
                margin: const EdgeInsets.only(
                  right: 10.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  border: Border.all(
                    width: 1.0,
                    color: Colors.white,
                  ),
                ),
                child: Text(
                  movie.genres![index].name!,
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class _BuildAppBar extends StatelessWidget {
  const _BuildAppBar({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final MovieDetail movie;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          movie.title!.length > 40
              ? "${movie.title!.substring(0, 37)}..."
              : movie.title!,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        background: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    UrlConst.originalImageUrl(movie.backdropPath!),
                  ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.1, 0.9],
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.0)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
