import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final String text;
  final Color fillColor;
  final Duration animationDuration;
  final double fontSize;

  const SplashScreen({
    super.key,
    this.text = 'MI APP',
    this.fillColor = Colors.deepPurple,
    this.animationDuration = const Duration(seconds: 2),
    this.fontSize = 48,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: widget.animationDuration)
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Texto base (color plomizo)
            Text(
              widget.text,
              style: TextStyle(
                fontSize: widget.fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.grey[400],
              ),
            ),

            // Texto con ShaderMask que sube como "líquido"
            AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                final progress = _controller.value;
                return ShaderMask(
                  blendMode: BlendMode.srcATop,
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        widget.fillColor,
                        widget.fillColor,
                        Colors.transparent,
                        Colors.transparent
                      ],
                      // stops para crear un borde brusco entre relleno y transparente
                      stops: [0.0, progress, progress, 1.0],
                    ).createShader(bounds);
                  },
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: widget.fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // necesario para que ShaderMask funcione bien
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

