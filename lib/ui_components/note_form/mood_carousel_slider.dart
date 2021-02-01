import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pnote/shared/constants.dart';
import 'package:pnote/ui_components/mood_image.dart';

class MoodCarouselSlider extends StatelessWidget {
  final Function(int value, CarouselPageChangedReason reason) onPageChanged;
  final int initialMoodPage;
  final double pageSize;

  MoodCarouselSlider({
    this.onPageChanged,
    this.initialMoodPage,
    this.pageSize = 150,
  });

  @override
  Widget build(BuildContext context) {
    final CarouselOptions carouselOptions = CarouselOptions(
      height: pageSize,
      scrollPhysics: BouncingScrollPhysics(),
      enlargeCenterPage: true,
      enableInfiniteScroll: false,
      initialPage: initialMoodPage,
      onPageChanged: onPageChanged,
    );

    return CarouselSlider.builder(
      itemCount: kMaxMood + 1,
      options: carouselOptions,
      itemBuilder: (BuildContext context, int itemIndex) {
        return MoodImage(
          mood: itemIndex,
          size: pageSize,
        );
      },
    );
  }
}
