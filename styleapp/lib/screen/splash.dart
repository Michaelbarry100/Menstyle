import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styleapp/utils/utils.dart';

import '../bloc/app/app_bloc.dart';
import '../theme.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _delaySplash();
  }

  _delaySplash() async {
    Future.delayed(const Duration(seconds: 2), () {
      BlocProvider.of<ApplicationBloc>(context).add(StartApp());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Semantics(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/icon.png'),
              semanticLabel: 'Men Fashion Styles Logo',
              width: 80,
            ),
            verticalSpacing(12),
            Text(
              "Men Fashion Styles",
              style: GoogleFonts.plusJakartaSans(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ],
        )),
      ),
    );
  }
}
