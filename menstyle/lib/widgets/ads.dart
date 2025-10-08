import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:styleapp/utils/utils.dart';

import '../api/AdMob.dart';

class GoogleBannerAd extends StatefulWidget {
  final double height;

  const GoogleBannerAd({super.key, this.height = 60});

  @override
  State<GoogleBannerAd> createState() => _GoogleBannerAdState();
}

class _GoogleBannerAdState extends State<GoogleBannerAd> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _createBannerAd();
  }

  void _createBannerAd() async {
    _bannerAd = BannerAd(
      adUnitId: AdMobAPI.bannerAdUnitId ?? '',
      request: const AdRequest(),
      size: AdSize.banner,
      listener: AdMobAPI.bannerAdListenner,
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return _bannerAd == null
        ? verticalSpacing(0)
        : Container(
            height: widget.height,
            width: double.maxFinite,
            margin: const EdgeInsets.only(bottom: 12),
            child: AdWidget(ad: _bannerAd!),
          );
  }
}

class GoogleRewardedAd extends StatefulWidget {
  const GoogleRewardedAd({super.key});

  @override
  _GoogleRewardedAdState createState() => _GoogleRewardedAdState();
}

class _GoogleRewardedAdState extends State<GoogleRewardedAd> {
  RewardedAd? _rewardedAd;
  
  _showRewardedAd() {
    if(_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _createRewardedAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _createRewardedAd();
        }
      );
      // _rewardedAd!.show(onUserEarnedReward: onUserEarnedReward)
    }
  }

  _createRewardedAd() {
    RewardedAd.load(
      adUnitId: AdMobAPI.rewardedAdUnitId ?? '',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) => setState(() => _rewardedAd = ad),
        onAdFailedToLoad: (error) => setState(() {
          _rewardedAd = null;
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
