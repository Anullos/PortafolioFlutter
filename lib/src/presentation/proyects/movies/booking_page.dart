import 'package:flutter/material.dart';
import 'package:portafolio_flutter/src/presentation/proyects/movies/config/app_colors.dart';
import 'package:portafolio_flutter/src/presentation/proyects/movies/config/app_text_styles.dart';
import 'package:portafolio_flutter/src/presentation/proyects/movies/custom_biometric_page.dart';
import 'package:portafolio_flutter/src/presentation/proyects/movies/data.dart';
import 'package:portafolio_flutter/src/presentation/proyects/movies/movie_page.dart';
import 'package:portafolio_flutter/src/presentation/proyects/movies/movies.dart';
import 'package:portafolio_flutter/src/presentation/proyects/movies/widgets/booking_page_animation.dart';
import 'package:portafolio_flutter/src/presentation/proyects/movies/widgets/custom_animated_opacity.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>
    with TickerProviderStateMixin {
  late final BookingPageAnimationController _controller;

  @override
  void initState() {
    _controller = BookingPageAnimationController(
      buttonController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 750),
      ),
      contentController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 750),
      ),
    );
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await _controller.buttonController.forward();
      await _controller.buttonController.reverse();
      await _controller.contentController.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final h = constraints.maxHeight;
      final w = constraints.maxWidth;
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          child: CustomAnimatedOpacity(
            animation: _controller.topOpacityAnimation,
            child: MovieAppBar(title: widget.movie.name),
          ),
          preferredSize: const Size.fromHeight(kToolbarHeight),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              width: w,
              height: h * 0.9,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const Spacer(),
                    CustomAnimatedOpacity(
                      animation: _controller.topOpacityAnimation,
                      child: SizedBox(
                        height: h * 0.075,
                        child: MovieDates(dates: widget.movie.dates),
                      ),
                    ),
                    const Spacer(),
                    CustomAnimatedOpacity(
                      animation: _controller.topOpacityAnimation,
                      child: SizedBox(
                        height: h * 0.2,
                        width: w,
                        child: MovieTeatherScreen(
                          image: widget.movie.image,
                          maxWidth: w,
                          maxHeigth: h,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    CustomAnimatedOpacity(
                      animation: _controller.bottomOpacityAnimation,
                      child: MovieSeats(
                        seats: widget.movie.seats,
                      ),
                    ),
                    const Spacer(),
                    CustomAnimatedOpacity(
                      animation: _controller.bottomOpacityAnimation,
                      child: const MovieSeatTypeLegend(),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: AnimatedBuilder(
                animation: _controller.buttonController,
                builder: (_, __) {
                  final size = _controller
                      .buttonSizeAnimation(
                        Size(w * 0.7, h * 0.06),
                        Size(w * 1.2, h * 1.1),
                      )
                      .value;
                  final margin =
                      _controller.buttonMarginAnimation(h * 0.03).value;
                  return GestureDetector(
                    onTap: () {
                      const transitionDuration = Duration(milliseconds: 400);

                      Navigator.of(context).push(PageRouteBuilder(
                        transitionDuration: transitionDuration,
                        reverseTransitionDuration: transitionDuration,
                        pageBuilder: (_, animation, __) {
                          return FadeTransition(
                            opacity: animation,
                            child: const CustomBiometricsPage(),
                          );
                        },
                      ));
                    },
                    child: Container(
                      height: size.height,
                      width: size.width,
                      margin: EdgeInsets.only(bottom: margin),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: h * 0.05,
              child: IgnorePointer(
                child: Text(
                  'Book Tickets',
                  style: AppTextStyles.bookButtonTextStyle,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class MovieDateCard extends StatelessWidget {
  const MovieDateCard({
    Key? key,
    required this.date,
    required this.isSelected,
  }) : super(key: key);

  final MovieDate date;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryColor : Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${date.day} ${date.month}',
            style: TextStyle(
                color: isSelected ? Colors.white70 : AppColors.primaryColor),
          ),
          const SizedBox(height: 5),
          Text(
            date.hour,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class MovieDates extends StatefulWidget {
  const MovieDates({
    Key? key,
    required this.dates,
  }) : super(key: key);

  final List<MovieDate> dates;

  @override
  State<MovieDates> createState() => _MovieDatesState();
}

class _MovieDatesState extends State<MovieDates> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, __) => const SizedBox(width: 10),
      clipBehavior: Clip.none,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: widget.dates.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
          },
          child: MovieDateCard(
            date: widget.dates[index],
            isSelected: index == _selectedIndex,
          ),
        );
      },
    );
  }
}

class MovieTeatherScreen extends StatelessWidget {
  const MovieTeatherScreen({
    Key? key,
    required this.image,
    required this.maxWidth,
    required this.maxHeigth,
  }) : super(key: key);

  final String image;
  final double maxWidth;
  final double maxHeigth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(.8),
          transformAlignment: Alignment.topCenter,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: maxHeigth * .025,
          height: maxHeigth * .03,
          width: maxWidth * .5,
          child: const CustomPaint(
            painter: MovieScreenLinePainter(),
          ),
        ),
      ],
    );
  }
}

class MovieScreenLinePainter extends CustomPainter {
  const MovieScreenLinePainter();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final h = size.height;
    final w = size.width;

    final path = Path()
      ..moveTo(0, h)
      ..quadraticBezierTo(w * 0.44, h * 0.57, w * 0.5, h * 0.6)
      ..quadraticBezierTo(w * 0.56, h * 0.57, w, h);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MovieSeats extends StatelessWidget {
  const MovieSeats({
    Key? key,
    required this.seats,
  }) : super(key: key);

  final List<List<Seat>> seats;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            for (int i = 0; i < 3; i++)
              MovieSeatSection(
                seats: seats[i],
                isFront: true,
              ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            for (int i = 3; i < 6; i++)
              MovieSeatSection(
                seats: seats[i],
              ),
          ],
        ),
      ],
    );
  }
}

class MovieSeatSection extends StatelessWidget {
  const MovieSeatSection({
    Key? key,
    required this.seats,
    this.isFront = false,
  }) : super(key: key);

  final List<Seat> seats;
  final bool isFront;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: isFront ? 16 : 20,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (_, index) {
          final seat = seats[index];
          return MovieSeatBox(seat: seat);
        },
      ),
    );
  }
}

class MovieSeatBox extends StatefulWidget {
  const MovieSeatBox({
    Key? key,
    required this.seat,
  }) : super(key: key);

  final Seat seat;

  @override
  State<MovieSeatBox> createState() => _SeatBoxState();
}

class _SeatBoxState extends State<MovieSeatBox> {
  @override
  Widget build(BuildContext context) {
    final color = widget.seat.isHidden
        ? Colors.white
        : widget.seat.isOcuppied
            ? Colors.black
            : widget.seat.isSelected
                ? AppColors.primaryColor
                : Colors.grey.shade200;
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.seat.isSelected = !widget.seat.isSelected;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(3),
          ),
        ),
      ),
    );
  }
}

class MovieSeatTypeLegend extends StatelessWidget {
  const MovieSeatTypeLegend({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: seatTypes
          .map(
            (seatType) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  SizedBox(
                    height: 12,
                    width: 12,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: seatType.color,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: Text(seatType.name),
                  )
                ],
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}
