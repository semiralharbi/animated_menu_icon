import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Animated Menu to X Icon'),
        ),
        body: const Center(
          child: MenuIcon(),
        ),
      ),
    );
  }
}

class MenuIcon extends StatefulWidget {
  const MenuIcon({super.key});

  @override
  MenuIconState createState() => MenuIconState();
}

class MenuIconState extends State<MenuIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controller.isCompleted) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: MenuPainter(_controller.value),
            size: const Size(100, 100),
          );
        },
      ),
    );
  }
}

class MenuPainter extends CustomPainter {
  MenuPainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width * 0.05;

    final double halfHeight = size.height / 2;
    final double halfWidth = size.width / 2;
    final double quarterHeight = size.height / 4;
    final double quarterWidth = size.width / 4;
    final double offsetX1 = progress * size.width * 0.08;
    final double offsetX2 = progress * size.width * 0.05;
    final double offsetY = progress * size.height * 0.1;
    final double topLineOffsetY = progress * size.height * 0.15;
    final double middleLineOffsetY = progress * size.height * 0.05;
    final double bottomLineOffsetY = progress * size.height * 0.2;

    final double rotation = progress * 45 * (3.1415927 / 180.0);

    final Offset center = Offset(halfWidth, halfHeight);

    // Draw top line
    canvas.save();
    canvas.translate(center.dx - offsetX1, center.dy);
    canvas.rotate(rotation);
    canvas.drawLine(
      Offset(-halfWidth + quarterWidth, -quarterHeight + topLineOffsetY),
      Offset(halfWidth - quarterWidth, -quarterHeight + topLineOffsetY),
      paint,
    );
    canvas.restore();

    // Draw middle line
    canvas.save();
    canvas.translate(center.dx - offsetX2, center.dy - offsetY);
    canvas.rotate(-rotation);
    canvas.drawLine(
      Offset(-halfWidth + quarterWidth, middleLineOffsetY),
      Offset(halfWidth - quarterWidth, middleLineOffsetY),
      paint,
    );
    canvas.restore();

    // Draw bottom line
    canvas.save();
    canvas.translate(center.dx - offsetX2, center.dy - offsetY);
    canvas.rotate(-rotation);
    canvas.drawLine(
      Offset(-halfWidth + quarterWidth, quarterHeight - bottomLineOffsetY),
      Offset(halfWidth - quarterWidth, quarterHeight - bottomLineOffsetY),
      paint,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
