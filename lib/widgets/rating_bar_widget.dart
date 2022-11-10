import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../utils/color_const.dart';

class RatingBarWidget extends StatelessWidget {
  final double voteAverage;
  const RatingBarWidget({super.key, required this.voteAverage});

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      itemSize: 10.0,
      initialRating: voteAverage / 2,
      ratingWidget: RatingWidget(
        empty: const Icon(
          EvaIcons.star,
          color: AppColors.secondColor,
        ),
        full: const Icon(
          EvaIcons.star,
          color: AppColors.secondColor,
        ),
        half: const Icon(
          EvaIcons.star,
          color: AppColors.secondColor,
        ),
      ),
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
      onRatingUpdate: (rating) {},
    );
  }
}
