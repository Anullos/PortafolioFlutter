import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:portafolio_flutter/src/presentation/proyects/multiplecard/city_model.dart';
import 'package:portafolio_flutter/src/presentation/proyects/multiplecard/multiple_details.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

const backgroundGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF4b6089),
    Color(0xFF9FB4D4),
  ],
);

class MultipleScreen extends StatefulWidget {
  const MultipleScreen({Key key}) : super(key: key);

  @override
  _MultipleScreenState createState() => _MultipleScreenState();
}

class _MultipleScreenState extends State<MultipleScreen>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController(viewportFraction: 0.8);
  AnimationController _animationController;
  double page = 0.0;

  void _listenScroll() {
    setState(() {
      page = _pageController.page;
    });
  }

  @override
  void initState() {
    _pageController.addListener(_listenScroll);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
      reverseDuration: const Duration(milliseconds: 1200),
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_listenScroll);
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onSwipe(City city) async {
    _animationController.forward();
    await Navigator.of(context).push(
      PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1200),
          pageBuilder: (context, animation, _) {
            return FadeTransition(
              opacity: animation,
              child: MultipleDetails(city: city),
            );
          }),
    );
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(gradient: backgroundGradient),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(_animationController),
                      ),
                      IconButton(
                        icon: Icon(Icons.settings_applications),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                      controller: _pageController,
                      itemCount: ciudades.length,
                      itemBuilder: (context, index) {
                        final ciudad = ciudades[index];
                        // abs para valores absolutos que no salgan en negativo
                        // clamp para que no sobrepase los valores por encima de 1
                        final percent = (page - index).abs().clamp(0.0, 1.0);
                        // para detectar si esta haciendo scroll por la izq o por la der
                        final factor =
                            _pageController.position.userScrollDirection ==
                                    ScrollDirection.forward
                                ? 1.0
                                : -1.0;
                        final opacity = percent.clamp(0.0, 0.7);
                        return Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(vector.radians(45 * percent * factor)),
                          child: Opacity(
                            opacity: (1 - opacity),
                            child: CityItem(
                              city: ciudad,
                              onSwipe: () {
                                _onSwipe(ciudad);
                              },
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends AnimatedWidget {
  final Animation<double> animation;
  const CustomTextField(this.animation, {Key key})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    // el align para que pueda cambiar el valor del container
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * (1 - animation.value),
        decoration: BoxDecoration(
            color: Color(0xFF8E9BB5), borderRadius: BorderRadius.circular(20)),
        child: animation.value < 0.4
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    Expanded(
                      child: Text('Search city...'),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

class CityItem extends StatelessWidget {
  final City city;
  final VoidCallback onSwipe;
  const CityItem({Key key, this.city, this.onSwipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta < -7) {
          onSwipe();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: CityWidget(city: city),
            ),
            Spacer(),
            Expanded(
              flex: 5,
              child: ReviewWidget(
                review: city.reviews.first,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CityWidget extends StatelessWidget {
  final City city;
  final EdgeInsets padding;
  const CityWidget({Key key, this.city, this.padding = EdgeInsets.zero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22.0);
    final subtitleStyle = TextStyle(
        color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18.0);
    return Hero(
      tag: 'city${city.name}',
      child: Card(
        elevation: 10,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                city.image,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Padding(
                padding: padding,
                child: Column(
                  children: [
                    Expanded(
                      child: Text(
                        city.name,
                        style: titleStyle,
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: Text(
                        city.name,
                        style: subtitleStyle.copyWith(shadows: [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(5.0, 5.0),
                            blurRadius: 5.0,
                            spreadRadius: 5.0,
                          ),
                        ]),
                      ),
                    ),
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

class ReviewWidget extends StatelessWidget {
  final CityReview review;

  const ReviewWidget({Key key, this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'review2_${review.name}',
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(review.image),
                  ),
                  const SizedBox(width: 10),
                  Text(review.name),
                ],
              ),
              const SizedBox(height: 15),
              Text(review.name),
              const SizedBox(height: 15),
              Expanded(
                child: Image.asset(
                  review.image,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
