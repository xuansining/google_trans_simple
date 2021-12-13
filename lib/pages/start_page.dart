import 'package:flutter/material.dart';
import '../index_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController!)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('index', (route) => false);
        }
      });
    _animationController?.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FadeTransition(
            opacity: _animation,
            child: Image.asset(
              'images/Open_animation.png',
              fit: BoxFit.cover,
            )));
  }
}
