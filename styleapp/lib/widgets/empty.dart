import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme.dart';

class EmptyData extends StatelessWidget {
  final String text;
  const EmptyData({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height /2.4,
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
