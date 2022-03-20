import 'package:flutter/material.dart';

class OpacityTween extends StatelessWidget {
  const OpacityTween({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 700),
    this.curve = Curves.easeInToLinear,
    this.begin = 0.2,
  }) : super(key: key);
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double begin;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: begin, end: 1.0),
      duration: duration,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: child,
    );
  }
}
