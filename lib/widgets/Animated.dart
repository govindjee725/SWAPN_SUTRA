import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedStars extends StatefulWidget {
  const AnimatedStars({super.key});

  @override
  _AnimatedStarsState createState() => _AnimatedStarsState();
}

class _AnimatedStarsState extends State<AnimatedStars>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Star> stars;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(duration: Duration(seconds: 20), vsync: this)
      ..repeat();

    stars = List.generate(
      40,
          (index) => Star(
        x: Random().nextDouble(),
        y: Random().nextDouble(),
        size: Random().nextDouble() * 2 + 1,
        speed: Random().nextDouble() * 0.5 + 0.2,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return CustomPaint(
          painter: StarPainter(stars, _controller.value),
        );
      },
    );
  }
}

class Star {
  final double x;
  double y;
  final double size;
  final double speed;

  Star({required this.x, required this.y, required this.size, required this.speed});
}

class StarPainter extends CustomPainter {
  final List<Star> stars;
  final double progress;

  StarPainter(this.stars, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.6);

    for (var star in stars) {
      double newY = (star.y + progress * star.speed) % 1.0;
      canvas.drawCircle(
        Offset(star.x * size.width, newY * size.height),
        star.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
