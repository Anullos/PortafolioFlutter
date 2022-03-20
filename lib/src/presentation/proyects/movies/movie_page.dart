import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portafolio_flutter/src/presentation/proyects/movies/booking_page.dart';
import 'package:portafolio_flutter/src/presentation/proyects/movies/config/app_colors.dart';
import 'package:portafolio_flutter/src/presentation/proyects/movies/config/app_text_styles.dart';
import 'package:portafolio_flutter/src/presentation/proyects/movies/movies.dart';
import 'package:portafolio_flutter/src/presentation/proyects/movies/widgets/opacity_tween.dart';
import 'package:portafolio_flutter/src/presentation/proyects/movies/widgets/slide_up_tween.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final h = constraints.maxHeight;
        final w = constraints.maxWidth;
        return Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                top: h * -0.1,
                width: w,
                height: h * 0.6,
                child: Hero(
                  tag: movie.image,
                  child: MovieCard(
                    image: movie.image,
                  ),
                ),
              ),
              Positioned(
                height: h * 0.5,
                width: w,
                child: Column(
                  children: [
                    const Spacer(),
                    Hero(
                      tag: movie.name,
                      child: Material(
                        type: MaterialType.transparency,
                        child: Text(movie.name.toUpperCase(),
                            style: AppTextStyles.movieNameTextStyle),
                      ),
                    ),
                    OpacityTween(
                      begin: 0.0,
                      child: SlideUpTween(
                        begin: const Offset(-30, 30),
                        child: MovieStars(
                          stars: movie.stars,
                        ),
                      ),
                    ),
                    const Spacer(),
                    OpacityTween(
                      child: SlideUpTween(
                        begin: const Offset(0, 200),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: w * 0.1),
                          child: Text(
                            movie.description,
                            style: AppTextStyles.movieDescriptionStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    OpacityTween(
                      child: SlideUpTween(
                        begin: const Offset(0, 200),
                        child: MovieInfoTable(
                          movie: movie,
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 5,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: h * 0.03,
                height: h * 0.06,
                width: w * 0.7,
                child: SlideUpTween(
                  begin: const Offset(-30, 60),
                  child: OpacityTween(
                    child: BookButton(
                      movie: movie,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: h * 0.05,
                child: const OpacityTween(
                  child: SlideUpTween(
                    begin: const Offset(-30, 60),
                    child: IgnorePointer(
                      child: Text(
                        'Book Tickets',
                        style: AppTextStyles.bookButtonTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(60),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: Offset(0, 20),
          ),
        ],
      ),
    );
  }
}

class MovieStars extends StatelessWidget {
  const MovieStars({Key? key, required this.stars}) : super(key: key);
  final int stars;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < stars; i++)
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
      ],
    );
  }
}

class MovieInfoTableItem extends StatelessWidget {
  const MovieInfoTableItem(
      {Key? key, required this.title, required this.content})
      : super(key: key);
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            title,
            style: AppTextStyles.infoTitleStyle,
          ),
        ),
        Text(
          content,
          style: AppTextStyles.infoContentStyle,
        ),
      ],
    );
  }
}

class MovieInfoTable extends StatelessWidget {
  const MovieInfoTable({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MovieInfoTableItem(title: 'Type', content: movie.type),
        MovieInfoTableItem(title: 'Hour', content: '${movie.hours} Hour'),
        MovieInfoTableItem(title: 'Director', content: movie.director),
      ],
    );
  }
}

class BookButton extends StatelessWidget {
  const BookButton({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        const transitionDuration = Duration(milliseconds: 200);

        Navigator.of(context).push(PageRouteBuilder(
          transitionDuration: transitionDuration,
          reverseTransitionDuration: transitionDuration,
          pageBuilder: (_, animation, __) {
            return FadeTransition(
              opacity: animation,
              child: BookingPage(
                movie: movie,
              ),
            );
          },
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

class MovieAppBar extends StatelessWidget {
  const MovieAppBar({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      foregroundColor: Colors.black,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop()),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
