import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfffafafa),
      width: double.infinity,
      height: double.infinity,
      child: Stack(children: [
        const _PurpleBox(),
        const _HeaderIcon(),
        child,
      ]),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: 200,
        child: Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  const _PurpleBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: _purpleBackground(),
      child: Stack(children: const [
        Positioned(top: 90, left: 30, child: _Bubble()),
        Positioned(top: -40, left: 50, child: _Bubble()),
        Positioned(top: -30, right: -60, child: _Bubble()),
        Positioned(bottom: 10, right: -40, child: _Bubble()),
        Positioned(top: 90, right: 20, child: _Bubble()),
        Positioned(bottom: 20, left: -10, child: _Bubble()),
      ]),
    );
  }

  BoxDecoration _purpleBackground() => const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(63, 63, 156, 1),
        Color.fromRGBO(90, 60, 178, 1),
      ]));
}

class _Bubble extends StatelessWidget {
  const _Bubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
  }
}
