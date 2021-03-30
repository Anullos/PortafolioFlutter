import 'package:flutter/material.dart';
import 'package:portafolio_flutter/src/presentation/proyects/multiplecard/city_model.dart';
import 'package:portafolio_flutter/src/presentation/proyects/multiplecard/multiple_screen.dart';

class MultipleDetails extends StatelessWidget {
  final City city;
  const MultipleDetails({Key key, this.city}) : super(key: key);

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: CityWidget(
                  city: city,
                  padding: EdgeInsets.only(left: 40, top: 40),
                ),
              ),
              Expanded(
                flex: 4,
                child: ListView.builder(
                  itemCount: city.reviews.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final review = city.reviews[index];
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: ReviewWidget(
                        review: review,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            left: 20,
            top: 20,
            child: BackButton(),
          ),
        ],
      ),
    );
  }
}
