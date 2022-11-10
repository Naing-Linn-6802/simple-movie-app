import 'package:flutter/material.dart';
import 'package:movie_app_by_nainglinn/utils/color_const.dart';
import 'package:movie_app_by_nainglinn/widgets/movies_gridview.dart';

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
              Padding(
                padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                child: Text(
                  "NOW PLAYING",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                child: Text(
                  "TOP RATED",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                child: Text(
                  "UPCOMMING",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                child: Text(
                  "POPULAR",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
