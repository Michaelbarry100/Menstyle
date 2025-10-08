import 'package:flutter/material.dart';
import 'package:styleapp/theme.dart';

class LaodingWidget extends StatelessWidget {
  const LaodingWidget({ super.key });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
          semanticsLabel: "Laoding Data",
        ),
    );
  }
}