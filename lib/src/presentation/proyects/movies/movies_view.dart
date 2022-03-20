import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portafolio_flutter/src/presentation/proyects/movies/config/app_text_styles.dart';
import 'package:portafolio_flutter/src/presentation/proyects/movies/data.dart';
import 'package:portafolio_flutter/src/presentation/proyects/movies/movie_page.dart';

class MoviesView extends StatefulWidget {
  const MoviesView({Key? key}) : super(key: key);

  @override
  _MoviesViewState createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {
  late final PageController _movieCardPageController;
  late final PageController _movieDetailPageController;

  double _movieCardPage = 0.0;
  double _movieDetailPage = 0.0;
  int _movieCardIndex = 0;
  final _showMovieDetails = ValueNotifier<bool>(true);

  @override
  void initState() {
    _movieCardPageController = PageController(viewportFraction: 0.77)
      ..addListener(_movieCardPageListener);
    _movieDetailPageController = PageController()
      ..addListener(_movieDetailsPercenListener);
    super.initState();
  }

  _movieCardPageListener() {
    setState(() {
      _movieCardPage = _movieCardPageController.page!;
      _movieCardIndex = _movieCardPageController.page!.round();
    });
  }

  _movieDetailsPercenListener() {
    setState(() {
      _movieDetailPage = _movieDetailPageController.page!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final h = constraints.maxHeight;
        final w = constraints.maxWidth;
        return Column(
          children: [
            const Spacer(),
            SizedBox(
              height: h * 0.6,
              child: PageView.builder(
                controller: _movieCardPageController,
                clipBehavior: Clip.none,
                onPageChanged: (page) {
                  _movieDetailPageController.animateToPage(
                    page,
                    duration: const Duration(milliseconds: 550),
                    curve: Curves.decelerate,
                  );
                },
                itemCount: movies.length,
                itemBuilder: (_, index) {
                  final movie = movies[index];
                  final progress = (_movieCardPage - index);
                  final scale = lerpDouble(1, 0.8, progress.abs())!;
                  final isScrolling = _movieCardPageController
                      .position.isScrollingNotifier.value;
                  final isCurrentPage = index == _movieCardIndex;
                  final isFirstPage = index == 0;

                  return Transform.scale(
                    scale: isScrolling && isFirstPage ? 1 - progress : scale,
                    alignment: Alignment.lerp(
                      Alignment.topLeft,
                      Alignment.center,
                      -progress,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        _showMovieDetails.value = !_showMovieDetails.value;
                        const transitionDuration = Duration(milliseconds: 550);
                        Navigator.of(context).push(PageRouteBuilder(
                          transitionDuration: transitionDuration,
                          reverseTransitionDuration: transitionDuration,
                          pageBuilder: (_, animation, __) {
                            return FadeTransition(
                              opacity: animation,
                              child: MoviePage(
                                movie: movie,
                              ),
                            );
                          },
                        ));
                        Future.delayed(transitionDuration, () {
                          _showMovieDetails.value = !_showMovieDetails.value;
                        });
                      },
                      child: Hero(
                        tag: movie.image,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          transform: Matrix4.identity()
                            ..translate(isCurrentPage ? 0.0 : -20.0,
                                isCurrentPage ? 0.0 : 60.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(70),
                            image: DecorationImage(
                              image: AssetImage(movie.image),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 25,
                                offset: Offset(0, 25),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            SizedBox(
              height: h * 0.25,
              child: PageView.builder(
                controller: _movieDetailPageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  final opacity = (index - _movieDetailPage).clamp(0.0, 1.0);
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.1),
                    child: Opacity(
                      opacity: 1 - opacity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: movie.name,
                            child: Material(
                              type: MaterialType.transparency,
                              child: Text(movie.name.toUpperCase(),
                                  style: AppTextStyles.movieNameTextStyle),
                            ),
                          ),
                          ValueListenableBuilder<bool>(
                            valueListenable: _showMovieDetails,
                            builder: (_, value, child) {
                              return Visibility(
                                visible: value,
                                child: child!,
                              );
                            },
                            child: Text(movie.actors.join(', '),
                                style: AppTextStyles.movieDetails),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
