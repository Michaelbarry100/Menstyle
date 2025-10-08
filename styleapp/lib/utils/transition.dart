import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Page animatePage({required BuildContext context, required Widget child, key}) {
  return CustomTransitionPage(
    child: child,
    transitionDuration: const Duration(milliseconds: 600),
    key: key,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInCubic).animate(animation),
        child: child,
      );
    },
  );
}
