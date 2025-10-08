import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:styleapp/theme.dart';
import 'package:styleapp/utils/utils.dart';
import 'package:styleapp/widgets/widgets.dart';

class LayoutWidget extends StatefulWidget {
  final bool isLoading;
  final Widget child;
  final String pageTitle;
  final double hPadding;
  const LayoutWidget(
      {super.key,
      required this.child,
      this.isLoading = false,
      this.hPadding = 20,
      required this.pageTitle});

  @override
  State<LayoutWidget> createState() => _LayoutWidgetState();
}

class _LayoutWidgetState extends State<LayoutWidget> {
  InterstitialAd? _interstitialAd;
  bool shownAd = false;
  bool shownAdFailed = false;

  @override
  void initState() {
    super.initState();
  }

  openAd() {
    loadInterstitialAd(onFailed: () {
      setState(() => _interstitialAd = null);
    }, onLoaded: (ad) {
      setState(() {
        _interstitialAd = ad;
      });
    });
    _showInterstitialAd();
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        loadInterstitialAd(onFailed: () {
          setState(() {
            _interstitialAd = null;
            shownAd = true;
          });
        }, onLoaded: (ad) {
          setState(() => _interstitialAd = ad);
        });
      }, onAdFailedToShowFullScreenContent: ((ad, error) {
        loadInterstitialAd(onFailed: () {
          setState(() {
            _interstitialAd = null;
            shownAd = true;
          });
        }, onLoaded: (ad) {
          setState(() => _interstitialAd = ad);
        });
      }));
      _interstitialAd!.show();
      setState(() {
        _interstitialAd = null;
        shownAd = true;
      });
    }
    context.pop();
    // if (!shownAd) {
    // } else if (shownAd) {
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(widget.pageTitle),
        elevation: 0,
        backgroundColor: AppColors.white,
        leadingWidth: 200,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.8),
          child: Container(
            color: AppColors.primary,
            height: 0.8,
          ),
        ),
        leading: InkWell(
          onTap: () {
            openAd();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: AppColors.black,
                ),
                horizontalSpacing(8),
                Text(widget.pageTitle,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black)),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: !widget.isLoading
            ? Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: widget.hPadding, vertical: 18),
                child: widget.child,
              )
            : const LaodingWidget(),
      ),
    );
  }
}
