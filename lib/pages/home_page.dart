import 'package:flutter/material.dart';
import 'package:simple_movie_app/utils/color_const.dart';
import 'package:simple_movie_app/widgets/movies_gridview.dart';

import '../utils/url_const.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Discover"),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: AppColors.secondColor,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3.0,
            unselectedLabelColor: AppColors.titleColor,
            labelColor: Colors.white,
            isScrollable: true,
            tabs: [
              _TabItemWidget(
                title: "NOW PLAYING",
              ),
              _TabItemWidget(
                title: "TOP RATED",
              ),
              _TabItemWidget(
                title: "UPCOMMING",
              ),
              _TabItemWidget(
                title: "POPULAR",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MoviesGridView(url: UrlConst.nowPlayingMovieUrl),
            MoviesGridView(url: UrlConst.popularMovieUrl),
            MoviesGridView(url: UrlConst.topRatedMovieUrl),
            MoviesGridView(url: UrlConst.upcomingMovieUrl),
          ],
        ),
      ),
    );
  }
}

class _TabItemWidget extends StatelessWidget {
  final String title;

  const _TabItemWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, top: 10.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
